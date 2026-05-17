import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["header"]

  sort(event) {
    const th = event.currentTarget
    const table = th.closest("table")
    const tbody = table.querySelector("tbody")
    const index = Array.from(th.parentElement.children).indexOf(th)
    const asc = th.dataset.sortDir !== "asc"

    // 他のヘッダーのソート状態をリセット
    th.parentElement.querySelectorAll("th[data-sort-dir]").forEach(el => {
      if (el !== th) delete el.dataset.sortDir
    })
    th.dataset.sortDir = asc ? "asc" : "desc"

    const rows = Array.from(tbody.querySelectorAll("tr"))
    rows.sort((a, b) => {
      const aText = a.children[index]?.textContent.trim() ?? ""
      const bText = b.children[index]?.textContent.trim() ?? ""
      const aNum = parseFloat(aText)
      const bNum = parseFloat(bText)
      const isNumeric = !isNaN(aNum) && !isNaN(bNum)
      const cmp = isNumeric ? aNum - bNum : aText.localeCompare(bText, "ja")
      return asc ? cmp : -cmp
    })

    rows.forEach(row => tbody.appendChild(row))
  }
}
