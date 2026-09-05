(function () {
    const dialog = document.getElementById("booking-access-dialog");
    if (!dialog || typeof dialog.showModal !== "function") return;

    const guestLink = dialog.querySelector("[data-guest-booking]");
    const defaultGuestUrl = guestLink ? guestLink.href : "";

    function openDialog(bookingUrl) {
        if (guestLink) guestLink.href = bookingUrl || defaultGuestUrl;
        dialog.showModal();
    }

    document.addEventListener("click", function (event) {
        const opener = event.target.closest("[data-booking-access-open]");
        if (opener) {
            event.preventDefault();
            openDialog(opener.getAttribute("href") || opener.dataset.bookingUrl || defaultGuestUrl);
            return;
        }

        const bookingLink = event.target.closest('a[href*="/booking?"]');
        if (bookingLink && !bookingLink.hasAttribute("data-guest-booking")) {
            event.preventDefault();
            openDialog(bookingLink.href);
        }
    });

    dialog.addEventListener("click", function (event) {
        if (event.target === dialog) dialog.close();
    });
    dialog.querySelectorAll("[data-dialog-close]").forEach(function (button) {
        button.addEventListener("click", function () { dialog.close(); });
    });
    dialog.querySelectorAll("[data-account-coming-soon]").forEach(function (button) {
        button.addEventListener("click", function () {
            const note = dialog.querySelector(".booking-access-note");
            note.hidden = false;
            note.focus();
        });
    });
})();