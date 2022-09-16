// Entry point for the build script in your package.json

import "@hotwired/turbo-rails"
import "./controllers"

// Habilita turbo drive.
// Por padrão já vem habilitado
// Turbo.session.drive = false


// seta um delay para exibir um feedback visual no navegador
// por padrão só é exibido quando a requisição demora mais de 500ms
Turbo.setProgressBarDelay(1)
