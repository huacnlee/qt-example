use std::collections::HashMap;

use qmetaobject::{prelude::*, QAbstractTableModel, QSingletonInit};
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

#[derive(Default, QObject)]
pub struct SimpleModel {
    base: qt_base_class!(trait QAbstractTableModel),

    stocks: Vec<StockItem>,
    counter: qt_property!(i32; NOTIFY counter_changed),
    counter_changed: qt_signal!(),

    message: qt_property!(QString; NOTIFY message_changed),
    message_changed: qt_signal!(),

    reload: qt_method!(fn(&mut self)),
    increment_number: qt_method!(fn(&mut self)),
    say_hi: qt_method!(fn(&self, string: QString, number: i32)),
}

#[derive(Default, Clone, Debug)]
pub struct StockItem {
    name: String,
    code: String,
    last_done: f64,
    up_down: i32,
}

impl QSingletonInit for SimpleModel {
    fn init(&mut self) {}
}

impl SimpleModel {
    fn reload(&mut self) {
        let mut new_stocks = Vec::new();
        let total = rand::random::<usize>() % 50000 + 100;

        for _ in 0..total {
            new_stocks.push(self.rand_stock_item());
        }
        self.stocks = new_stocks
    }

    fn increment_number(&mut self) {
        self.counter += 1;
        self.counter_changed();
    }

    fn say_hi(&self, string: QString, number: i32) {
        println!("Hi from Rust! String is '{string}' and number is {number}");
    }

    fn rand_stock_item(&self) -> StockItem {
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
}

impl QAbstractTableModel for SimpleModel {
    fn role_names(&self) -> HashMap<i32, QByteArray> {
        let mut map: HashMap<i32, QByteArray> = HashMap::new();
        map.insert(99, "column_name".into());
        map.insert(0, "display".into());
        map.insert(1, "up_down".into());
        map.insert(2, "last_done".into());
        map
    }

    fn row_count(&self) -> i32 {
        self.stocks.len() as i32
    }

    fn column_count(&self) -> i32 {
        3
    }

    fn data(&self, index: QModelIndex, role: i32) -> QVariant {
        let row = index.row() as usize;
        if let Some(stock_item) = &self.stocks.get(row) {
            return match role {
                99 => match index.column() {
                    0 => QString::from("Name").into(),
                    1 => QString::from("Code").into(),
                    2 => QString::from("Last Done").into(),
                    _ => QVariant::default(),
                },
                0 => match index.column() {
                    0 => QString::from(stock_item.name.clone()).into(),
                    1 => QString::from(stock_item.code.clone()).into(),
                    2 => QVariant::from(stock_item.last_done),
                    _ => QVariant::default(),
                },
                1 => QVariant::from(&stock_item.up_down),
                2 => QVariant::from(&stock_item.last_done),

                _ => QVariant::default(),
            };
        }

        QVariant::default()
    }

    // fn header_data(&self, section: i32, orientation: Orientation, role: i32) -> QVariant {
    //     if role != USER_ROLE || orientation != Orientation::Horizontal {
    //         return QVariant::default();
    //     }

    //     match section {
    //         0 => QVariant::from(&QString::from("Name")),
    //         1 => QVariant::from(&QString::from("Code")),
    //         2 => QVariant::from(&QString::from("Last Done")),
    //         _ => QVariant::default(),
    //     }
    // }
}
