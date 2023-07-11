export function loadData(
  myObject,
  tableView,
  { tableRowAction, tableRowLastDone }
) {
  const stocksCount = myObject.stocksCount();
  const columnNames = myObject.columnNames();

  const dataSource = [];
  for (var i = 0; i < stocksCount; i++) {
    let name = myObject.stock(i, 0);
    let code = myObject.stock(i, 1);
    let last_done = myObject.stock(i, 2);
    let up_down = myObject.stock(i, 3);

    dataSource.push({
      name,
      code,
      up_down,
      last_done_val: last_done,
      last_done: tableRowLastDone,
      height: 40,
      minimumHeight: 40,
      maximumHeight: 200,
      // action:com_action
      action: tableRowAction,
    });
  }
  tableView.dataSource = dataSource;
}

export function showInfo(message) {}
