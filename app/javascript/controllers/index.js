// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import RailsNestedForm from '@stimulus-components/rails-nested-form'
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

application.register('nested-form', RailsNestedForm)

eagerLoadControllersFrom("controllers", application)
