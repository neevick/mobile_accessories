(function () {
    var activeDialog = null;
    var previousBodyOverflow = '';

    function closeDialog(dialog) {
        if (!dialog) {
            return;
        }

        dialog.remove();
        document.body.style.overflow = previousBodyOverflow;
        activeDialog = null;
    }

    function showLogoutDialog(logoutUrl) {
        closeDialog(activeDialog);

        var overlay = document.createElement('div');
        overlay.className = 'logout-dialog-overlay';
        overlay.style.cssText = [
            'position: fixed',
            'top: 0',
            'right: 0',
            'bottom: 0',
            'left: 0',
            'z-index: 9999',
            'display: block',
            'background: rgba(0, 0, 0, 0.55)'
        ].join(';');
        overlay.innerHTML =
            '<div class="logout-dialog" role="dialog" aria-modal="true" aria-labelledby="logoutDialogTitle" aria-describedby="logoutDialogMessage">' +
                '<button type="button" class="logout-dialog-close" aria-label="Close logout dialog" data-logout-confirm="no">&times;</button>' +
                '<div class="logout-dialog-header" id="logoutDialogTitle">Confirm</div>' +
                '<p id="logoutDialogMessage">Are you sure you want to logout?</p>' +
                '<div class="logout-dialog-actions">' +
                    '<button type="button" class="logout-dialog-confirm" data-logout-confirm="yes">Yes</button>' +
                    '<button type="button" class="logout-dialog-cancel" data-logout-confirm="no">No</button>' +
                '</div>' +
            '</div>';

        overlay.addEventListener('click', function (event) {
            if (event.target === overlay || event.target.dataset.logoutConfirm === 'no') {
                closeDialog(overlay);
            }

            if (event.target.dataset.logoutConfirm === 'yes') {
                window.location.href = logoutUrl;
            }
        });

        overlay.addEventListener('keydown', function (event) {
            if (event.key === 'Escape') {
                closeDialog(overlay);
            }
        });

        document.body.appendChild(overlay);
        previousBodyOverflow = document.body.style.overflow;
        document.body.style.overflow = 'hidden';
        activeDialog = overlay;
        overlay.querySelector('.logout-dialog').style.cssText = [
            'position: fixed',
            'top: 50%',
            'left: 50%',
            'width: min(calc(100% - 2rem), 400px)',
            'padding: 0 0 2.75rem',
            'border: 1px solid #cfcfcf',
            'border-radius: 4px',
            'background: #ffffff',
            'box-shadow: 0 2px 18px rgba(0, 0, 0, 0.28)',
            'text-align: center',
            'transform: translate(-50%, -50%)'
        ].join(';');
        overlay.querySelector('[data-logout-confirm="yes"]').focus();
    }

    document.addEventListener('click', function (event) {
        var logoutLink = event.target.closest('.logout-link');
        if (!logoutLink) {
            return;
        }

        event.preventDefault();
        showLogoutDialog(logoutLink.href);
    });
}());
