use rand::Rng;

static STOCK_NAME_CODES: [(&str, &str); 20] = [
    ("Apple", "AAPL"),
    ("Microsoft", "MSFT"),
    ("Google", "GOOG"),
    ("Amazon", "AMZN"),
    ("Facebook", "FB"),
    ("Tesla", "TSLA"),
    ("Alibaba", "BABA"),
    ("Tencent", "TCEHY"),
    ("Berkshire Hathaway", "BRK-A"),
    ("JPMorgan Chase", "JPM"),
    ("Johnson & Johnson", "JNJ"),
    ("Visa", "V"),
    ("ExxonMobil", "XOM"),
    ("Samsung", "SSNLF"),
    ("Walmart", "WMT"),
    ("Procter & Gamble", "PG"),
    ("UnitedHealth", "UNH"),
    ("Home Depot", "HD"),
    ("Taiwan Semiconductor", "TSM"),
    ("Mastercard", "MA"),
];

fn rand_stock_item() -> StockItem {
    let mut rng = rand::thread_rng();
    let (name, code) = STOCK_NAME_CODES[rng.gen::<usize>() % STOCK_NAME_CODES.len()];
    let last_done = rng.gen::<f64>() * 100.0;

    StockItem {
        name: String::from(name),
        code: String::from(code),
        last_done,
        up_down: rng.gen_range(-1..=1),
    }
}

#[derive(Default, Clone, Debug)]
pub struct StockItem {
    name: String,
    code: String,
    last_done: f64,
    up_down: i32,
}

#[cxx_qt::bridge]
pub mod ffi {
    use super::{rand_stock_item, StockItem};

    unsafe extern "C++" {
        include!(< QAbstractListModel >);

        include!("cxx-qt-lib/qvariant.h");
        type QVariant = cxx_qt_lib::QVariant;

        include!("cxx-qt-lib/qstring.h");
        type QString = cxx_qt_lib::QString;

        include!("cxx-qt-lib/qhash.h");
        type QHash_i32_QByteArray = cxx_qt_lib::QHash<cxx_qt_lib::QHashPair_i32_QByteArray>;

        include!("cxx-qt-lib/qmodelindex.h");
        type QModelIndex = cxx_qt_lib::QModelIndex;
    }

    // Types:
    // https://kdab.github.io/cxx-qt/book/concepts/types.html
    //
    #[cxx_qt::qobject(qml_uri = "com.company.example", qml_version = "1.0")]
    #[derive(Default, Debug)]
    pub struct MyObject {
        #[qproperty]
        number: i32,
        #[qproperty]
        string: QString,
    }

    impl qobject::MyObject {
        #[qinvokable]
        pub fn increment_number(mut self: Pin<&mut Self>) {
            let previous = *self.as_ref().number();

            self.as_mut().set_number(previous + 1);
        }

        #[qinvokable]
        pub fn say_hi(&self, string: &QString, number: i32) {
            println!("Hi from Rust! String is '{string}' and number is {number}");
        }
    }

    // https://github.com/ChrisCochrun/libre-presenter/blob/3f00cf7abd5163aeb9c328e27284aa6c1beceae0/src/rust/song_model.rs
    #[cxx_qt::qobject(
        base = "QAbstractListModel",
        qml_uri = "com.company.example",
        qml_version = "1.0"
    )]
    #[derive(Default, Debug)]
    pub struct Watchlist {
        stocks: Vec<StockItem>,
    }

    // QAbstractListModel implementation
    impl qobject::Watchlist {
        #[qinvokable]
        pub fn reload(mut self: Pin<&mut Self>) {
            let mut new_stocks = Vec::new();
            let total = rand::random::<usize>() % 50000 + 100;

            for _ in 0..total {
                new_stocks.push(rand_stock_item());
            }
            self.as_mut().set_stocks(new_stocks)
        }

        #[qinvokable(cxx_override)]
        pub fn role_names(&self) -> QHash_i32_QByteArray {
            let mut roles = QHash_i32_QByteArray::default();
            roles.insert(0, cxx_qt_lib::QByteArray::from("display"));
            roles.insert(1, cxx_qt_lib::QByteArray::from("up_down"));
            roles.insert(2, cxx_qt_lib::QByteArray::from("last_done"));
            roles
        }

        #[qinvokable(cxx_override)]
        pub fn column_count(&self, _parent: &QModelIndex) -> i32 {
            let count = 3;
            count
        }

        #[qinvokable(cxx_override)]
        pub fn row_count(&self, _parent: &QModelIndex) -> i32 {
            let count = self.rust().stocks.len() as i32;
            count
        }

        #[qinvokable(cxx_override)]
        fn data(&self, index: &QModelIndex, role: i32) -> QVariant {
            let row = index.row() as usize;
            if let Some(stock_item) = &self.stocks().get(row) {
                return match role {
                    0 => match index.column() {
                        0 => QVariant::from(&QString::from(&stock_item.name)),
                        1 => QVariant::from(&QString::from(&stock_item.code)),
                        2 => QVariant::from(&stock_item.last_done),
                        _ => QVariant::default(),
                    },
                    1 => QVariant::from(&stock_item.up_down),
                    2 => QVariant::from(&stock_item.last_done),

                    _ => QVariant::default(),
                };
            }

            QVariant::default()
        }
    }
}
