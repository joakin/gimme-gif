export default function (id) {
  var app = document.createElement('div')
  app.id = id
  document.body.appendChild(app)
  return app
}
