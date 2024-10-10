// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import AutocompleteController from "./autocomplete_controller"
application.register("autocomplete", AutocompleteController)

import CategoryAutocompleteController from "./category_autocomplete_controller"
application.register("category-autocomplete", CategoryAutocompleteController)

import FeatureToggleController from "./feature_toggle_controller"
application.register("feature-toggle", FeatureToggleController)

import FilterController from "./filter_controller"
application.register("filter", FilterController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import OpenSourceProjectController from "./open_source_project_controller"
application.register("open-source-project", OpenSourceProjectController)

import PopoverController from "./popover_controller"
application.register("popover", PopoverController)

import RichTextController from "./rich_text_controller"
application.register("rich-text", RichTextController)

import TabsController from "./tabs_controller"
application.register("tabs", TabsController)
