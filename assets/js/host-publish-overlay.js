'use strict';

(function () {
    const RING = 2 * Math.PI * 54;

    let overlay = null;
    let page = null;
    let percentEl = null;
    let ringEl = null;
    let barEl = null;
    let hintEl = null;
    let titleEl = null;
    let active = false;
    let shown = 1;
    let target = 1;
    let rafId = 0;
    let creepId = 0;

    const clamp = (value) => Math.min(100, Math.max(1, value));

    const paint = () => {
        if (!percentEl || !ringEl || !barEl) {
            return;
        }
        const value = Math.round(shown);
        percentEl.textContent = value + '%';
        ringEl.style.strokeDashoffset = String(RING * (1 - value / 100));
        barEl.style.transform = 'scaleX(' + (value / 100) + ')';
    };

    const loop = () => {
        if (!active) {
            return;
        }
        const delta = target - shown;
        shown = Math.abs(delta) < 0.25 ? target : shown + delta * 0.18;
        paint();
        rafId = window.requestAnimationFrame(loop);
    };

    const stopTimers = () => {
        if (rafId) {
            window.cancelAnimationFrame(rafId);
            rafId = 0;
        }
        if (creepId) {
            window.clearInterval(creepId);
            creepId = 0;
        }
    };

    const bind = () => {
        if (overlay) {
            return true;
        }
        page = document.querySelector('.host-admin-content.host-page');
        overlay = document.getElementById('hostPublishOverlay');
        if (!overlay || !page) {
            return false;
        }
        percentEl = overlay.querySelector('[data-publish-percent]');
        ringEl = overlay.querySelector('[data-publish-ring]');
        barEl = overlay.querySelector('[data-publish-bar]');
        hintEl = overlay.querySelector('[data-publish-hint]');
        titleEl = overlay.querySelector('.host-publish-title');
        if (ringEl) {
            ringEl.style.strokeDasharray = String(RING);
            ringEl.style.strokeDashoffset = String(RING * 0.99);
        }
        return true;
    };

    window.HostPublishOverlay = {
        start(options) {
            if (!bind()) {
                return;
            }

            const opts = options || {};
            active = true;
            shown = 1;
            target = 4;
            overlay.classList.remove('is-complete');
            overlay.hidden = false;
            overlay.classList.add('is-visible');
            page.classList.add('is-publish-overlay-active');

            if (opts.title && titleEl) {
                titleEl.textContent = opts.title;
            }
            if (opts.hint && hintEl) {
                hintEl.textContent = opts.hint;
            }

            stopTimers();
            paint();
            rafId = window.requestAnimationFrame(loop);
            creepId = window.setInterval(() => {
                if (active && target < 90) {
                    target = clamp(target + 1.2);
                }
            }, 90);
        },

        setProgress(percent) {
            if (active) {
                target = clamp(Math.max(target, percent));
            }
        },

        setHint(message) {
            if (active && hintEl && message) {
                hintEl.textContent = message;
            }
        },

        complete(doneMessage) {
            if (!active) {
                return Promise.resolve();
            }
            if (creepId) {
                window.clearInterval(creepId);
                creepId = 0;
            }
            target = 100;
            overlay.classList.add('is-complete');
            if (doneMessage && hintEl) {
                hintEl.textContent = doneMessage;
            }
            return new Promise((resolve) => {
                const wait = () => {
                    if (!active || shown >= 99.4) {
                        shown = 100;
                        paint();
                        window.setTimeout(resolve, 180);
                        return;
                    }
                    window.requestAnimationFrame(wait);
                };
                wait();
            });
        },

        fail() {
            this.destroy();
        },

        destroy() {
            stopTimers();
            active = false;
            if (overlay) {
                overlay.classList.remove('is-visible', 'is-complete');
                overlay.hidden = true;
            }
            page?.classList.remove('is-publish-overlay-active');
        },
    };

    const listingKind = (form) => {
        const checked = form.querySelector('input[name="listing_kind"]:checked');
        if (checked) {
            return checked.value;
        }
        const hidden = form.querySelector('input[name="listing_kind"][type="hidden"]');
        return hidden?.value || form.dataset.listingKind || 'logement';
    };

    const overlayCopy = (form) => {
        const land = listingKind(form) === 'terrain';
        return {
            title: land
                ? (form.dataset.publishOverlayTitleLand || 'Publication de votre terrain')
                : (form.dataset.publishOverlayTitle || 'Publication de votre annonce'),
            hint: land
                ? (form.dataset.publishOverlayHintLand || 'Enregistrement des photos et mise en vente du terrain.')
                : (form.dataset.publishOverlayHint || 'Veuillez patienter…'),
            done: land
                ? (form.dataset.publishOverlayDoneLand || 'Terrain publié avec succès !')
                : (form.dataset.publishOverlayDone || 'Annonce publiée avec succès !'),
        };
    };

    const hasEnoughPhotos = () => {
        const counter = document.getElementById('hostImagesCounter');
        const minPhotos = parseInt(counter?.dataset.min || '4', 10);
        const photoCount = document.querySelectorAll('#hostImagesGrid .host-image-card:not(.host-image-add):not([hidden])').length;
        return photoCount >= minPhotos;
    };

    const visibleFormIsValid = (form) => {
        const fields = form.querySelectorAll('input, select, textarea');
        for (const field of fields) {
            if (field.disabled || field.closest('[hidden]')) {
                continue;
            }
            if (typeof field.checkValidity === 'function' && !field.checkValidity()) {
                return false;
            }
        }
        return true;
    };

    const bootButton = () => {
        const btn = document.getElementById('hostPublishBtn');
        const form = document.querySelector('.host-form-simple[data-host-managed="1"]');
        if (!btn || !form) {
            return;
        }

        window.__hostPublishCopy = () => overlayCopy(form);

        btn.addEventListener('click', () => {
            if (!visibleFormIsValid(form) || !hasEnoughPhotos()) {
                return;
            }
            window.HostPublishOverlay.start(overlayCopy(form));
        });
    };

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', bootButton);
    } else {
        bootButton();
    }
})();
