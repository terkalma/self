module Admin::XlsxHelper
  def xlsx_index_for(row, col)
    c = 'A'
    col.to_i.times { c.succ! }

    "#{c}#{row.to_i + 1}"
  end

  def xlsx_range(row_a, col_a, row_b, col_b)
    "#{xlsx_index_for row_a, col_a}:#{xlsx_index_for row_b, col_b}"
  end

  def xlsx_sum(range)
    "=SUM(#{range})"
  end
end