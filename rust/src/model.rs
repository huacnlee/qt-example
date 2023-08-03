#[cxx_qt::bridge]
pub mod ffi {
    use crate::watchlist::StockItem;

    unsafe extern "C++" {
        include!(< QAbstractTableModel >);

        include!("cxx-qt-lib/qvariant.h");
        type QVariant = cxx_qt_lib::QVariant;

        include!("cxx-qt-lib/qstring.h");
        type QString = cxx_qt_lib::QString;

        include!("cxx-qt-lib/qhash.h");
        type QHash_i32_QByteArray = cxx_qt_lib::QHash<cxx_qt_lib::QHashPair_i32_QByteArray>;

        include!("cxx-qt-lib/qmodelindex.h");
        type QModelIndex = cxx_qt_lib::QModelIndex;

        include!("cxx-qt-lib/qvector.h");
        type QVector_i32 = cxx_qt_lib::QVector<i32>;
    }

    // Types:
    // https://kdab.github.io/cxx-qt/book/concepts/types.html
    //
    #[cxx_qt::qobject(
        base = "QAbstractTableModel",
        qml_uri = "QtExample",
        qml_version = "1.0"
    )]
    #[derive(Default, Debug)]
    pub struct SimpleModel {
        #[qproperty]
        counter: i32,

        #[qproperty]
        message: QString,

        stocks: Vec<StockItem>,
    }

    #[cxx_qt::qsignals(SimpleModel)]
    pub enum Signals<'a> {
        #[inherit]
        DataChanged {
            top_left: &'a QModelIndex,
            bottom_right: &'a QModelIndex,
            roles: &'a QVector_i32,
        },
        #[inherit]
        LayoutChanged {}
    }

    // Ref: https://github.com/ChrisCochrun/libre-presenter/blob/master/src/rust/song_model.rs
    impl qobject::SimpleModel {
        
        #[qinvokable]
        pub fn increment_number(mut self: Pin<&mut Self>) {
            let previous = *self.as_ref().counter();

            self.as_mut().set_counter(previous + 1);
        }

        #[qinvokable]
        pub fn say_hi(&self, string: &QString, number: i32) {
            println!("Hi from Rust! String is '{string}' and number is {number}");
        }

        #[qinvokable]
        fn reload(mut self: Pin<&mut Self>) {
            if self.rust().stocks.is_empty() {
                let mut new_stocks = Vec::new();
                let total = rand::random::<usize>() % 50000 + 100;

                for _ in 0..total {
                    new_stocks.push(StockItem::random());
                }
                self.as_mut().set_stocks(new_stocks);
            } else {
                let new_stocks = self
                    .rust()
                    .stocks
                    .iter()
                    .map(|stock_item| stock_item.clone().random_last_done())
                    .collect();

                self.as_mut().set_stocks(new_stocks);
                self.update_tableview();
            }
        }

        fn update_tableview(mut self: Pin<&mut Self>) {
            self.as_mut().emit(Signals::LayoutChanged {});
        }


        #[qinvokable(cxx_override)]
        pub fn role_names(&self) -> QHash_i32_QByteArray {
            let mut roles = QHash_i32_QByteArray::default();
            roles.insert(99, cxx_qt_lib::QByteArray::from("column_name"));
            roles.insert(0, cxx_qt_lib::QByteArray::from("display"));
            roles.insert(1, cxx_qt_lib::QByteArray::from("up_down"));
            roles.insert(2, cxx_qt_lib::QByteArray::from("last_done"));
            roles
        }

        #[qinvokable(cxx_override)]
        pub fn column_count(&self, _parent: &QModelIndex) -> i32 {
            3
        }

        #[qinvokable(cxx_override)]
        pub fn row_count(&self, _parent: &QModelIndex) -> i32 {
            self.rust().stocks.len() as i32
        }

        #[qinvokable(cxx_override)]
        fn data(&self, index: &QModelIndex, role: i32) -> QVariant {
            let row = index.row() as usize;
            if let Some(stock_item) = &self.rust().stocks.get(row) {
                return match role {
                    99 => match index.column() {
                        0 => QVariant::from(&QString::from("Name")),
                        1 => QVariant::from(&QString::from("Code")),
                        2 => QVariant::from(&QString::from("Last Done")),
                        _ => QVariant::default(),
                    },
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
