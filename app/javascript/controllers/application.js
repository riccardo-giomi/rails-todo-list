import { Application } from "@hotwired/stimulus";

const application = Application.start();

// import { Alert, Autosave, Dropdown, Modal, Tabs, Popover, Toggle, Slideover } from "tailwindcss-stimulus-components"
import { Alert, Popover } from "tailwindcss-stimulus-components";
application.register("alert", Alert);
application.register("popover", Popover);

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };
