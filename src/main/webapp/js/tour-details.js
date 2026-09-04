(() => {
    const dialog = document.querySelector('.journey-lightbox');
    const photos = [...document.querySelectorAll('.journey-photo')];
    if (!dialog || typeof dialog.showModal !== 'function' || !photos.length) return;
    let current = 0;
    const image = dialog.querySelector('img');
    const counter = dialog.querySelector('[aria-live]');
    const show = index => {
        current = (index + photos.length) % photos.length;
        image.src = photos[current].href;
        image.alt = photos[current].querySelector('img').alt;
        counter.textContent = (current + 1) + ' / ' + photos.length;
    };
    photos.forEach((link, index) => link.addEventListener('click', event => {
        if (event.ctrlKey || event.metaKey || event.shiftKey || event.altKey) return;
        event.preventDefault();
        show(index);
        dialog.showModal();
    }));
    dialog.querySelector('.journey-lightbox-close').addEventListener('click', () => dialog.close());
    dialog.querySelectorAll('[data-direction]').forEach(button => {
        button.hidden = photos.length < 2;
        button.addEventListener('click', () => show(current + Number(button.dataset.direction)));
    });
    dialog.addEventListener('keydown', event => {
        if (event.key === 'ArrowRight' || event.key === 'ArrowLeft') {
            event.preventDefault();
            show(current + (event.key === 'ArrowRight' ? 1 : -1));
        }
    });
    dialog.addEventListener('click', event => {
        const bounds = dialog.getBoundingClientRect();
        if (event.clientX < bounds.left || event.clientX > bounds.right || event.clientY < bounds.top || event.clientY > bounds.bottom) dialog.close();
    });
})();
