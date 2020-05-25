let theme = document.querySelector("#theme")
let select = theme.querySelector("select")
theme.classList.remove("disabled")
select.disabled = false
select.addEventListener("click", () => document.body.dataset.theme = select.value)

CSS.registerProperty({name: "--text-color", syntax: "<color>", inherits: true, initialValue: "#0000"})
CSS.registerProperty({name: "--background-color", syntax: "<color>", inherits: true, initialValue: "#0000"})
