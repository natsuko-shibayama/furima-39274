window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  const feeDisplay = document.getElementById("add-tax-price");
  const profitDisplay = document.getElementById("profit");

  if (priceInput) {
    priceInput.addEventListener("input", () => {
      const price = parseInt(priceInput.value);
      const tax = Math.floor(price * 0.1);
      const profit = price - tax;
  
      feeDisplay.innerHTML = tax.toLocaleString();
      profitDisplay.innerHTML = profit.toLocaleString();
    });
  }
});