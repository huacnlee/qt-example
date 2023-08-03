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

#[derive(Default, Clone, Debug)]
pub struct StockItem {
    pub name: String,
    pub code: String,
    pub last_done: f64,
    pub prev_close: f64,
    pub up_down: i32,
}

impl StockItem {
    pub fn random() -> StockItem {
        let mut rng = rand::thread_rng();
        let (name, code) = STOCK_NAME_CODES[rng.gen::<usize>() % STOCK_NAME_CODES.len()];
        let last_done = rng.gen::<f64>() * 100.0;
        let prev_close = last_done * rng.gen_range(0.95..=1.05);

        let mut item = StockItem {
            name: String::from(name),
            code: String::from(code),
            last_done: 0.0,
            prev_close: 0.0,
            up_down: 0,
        };
        item.set_done(prev_close, last_done);

        item
    }

    pub fn set_done(&mut self, prev_close: f64, last_done: f64) {
        self.up_down = 0;
        self.prev_close = prev_close;
        self.last_done = last_done;

        if self.last_done > self.prev_close {
            self.up_down = 1;
        } else if self.last_done < self.prev_close {
            self.up_down = -1;
        }
    }

    pub fn random_last_done(mut self) -> StockItem {
        let mut rng = rand::thread_rng();
        self.set_done(
            self.prev_close,
            self.prev_close * rng.gen_range(0.99..=1.010),
        );
        self
    }
}
