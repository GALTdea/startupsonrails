export class Popover {
    constructor(element, options = {}) {
        this.element = element;
        this.content = options.content || '';
        this.placement = options.placement || 'top';
        this.offset = options.offset || 10;
        this.popoverElement = null;
        this.showEvents = ['click', 'focus'];
        this.hideEvents = ['blur'];

        this.show = this.show.bind(this);
        this.hide = this.hide.bind(this);
        this.create = this.create.bind(this);
    }

    init() {
        this.create();
        this.addEventListeners();
    }

    create() {
        this.popoverElement = document.createElement('div');
        this.popoverElement.className = 'custom-popover';
        this.popoverElement.textContent = this.content;
        this.popoverElement.style.position = 'absolute';
        this.popoverElement.style.zIndex = '1000';
        this.popoverElement.style.backgroundColor = 'white';
        this.popoverElement.style.padding = '8px';
        this.popoverElement.style.borderRadius = '4px';
        this.popoverElement.style.boxShadow = '0 2px 5px rgba(0,0,0,0.2)';
        this.popoverElement.style.display = 'none';
        document.body.appendChild(this.popoverElement);
    }

    show() {
        const rect = this.element.getBoundingClientRect();
        const scrollLeft = window.pageXOffset || document.documentElement.scrollLeft;
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;

        let top, left;

        switch (this.placement) {
            case 'top':
                top = rect.top + scrollTop - this.popoverElement.offsetHeight - this.offset;
                left = rect.left + scrollLeft + (rect.width - this.popoverElement.offsetWidth) / 2;
                break;
            // Add cases for 'bottom', 'left', 'right' if needed
        }

        this.popoverElement.style.top = `${top}px`;
        this.popoverElement.style.left = `${left}px`;
        this.popoverElement.style.display = 'block';
    }

    hide() {
        this.popoverElement.style.display = 'none';
    }

    addEventListeners() {
        this.showEvents.forEach(event => {
            this.element.addEventListener(event, this.show);
        });

        this.hideEvents.forEach(event => {
            this.element.addEventListener(event, this.hide);
        });
    }

    destroy() {
        this.showEvents.forEach(event => {
            this.element.removeEventListener(event, this.show);
        });

        this.hideEvents.forEach(event => {
            this.element.removeEventListener(event, this.hide);
        });

        if (this.popoverElement && this.popoverElement.parentNode) {
            this.popoverElement.parentNode.removeChild(this.popoverElement);
        }
    }
}