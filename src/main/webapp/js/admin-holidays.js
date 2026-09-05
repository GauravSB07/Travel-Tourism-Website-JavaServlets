(() => {
  const search = document.getElementById('holiday-search');
  const items = [...document.querySelectorAll('.holiday-item')];
  search.addEventListener('input', () => {
    let count = 0;
    items.forEach(item => { item.hidden = !item.textContent.toLowerCase().includes(search.value.trim().toLowerCase()); if (!item.hidden) count++; });
    document.getElementById('search-count').textContent = count + ' packages';
    document.getElementById('no-results').hidden = count !== 0;
  });
  const form = document.getElementById('holiday-form');
  const container = document.getElementById('itinerary-days');
  const duration = document.getElementById('holiday-duration');
  const add = document.getElementById('add-day');
  let dirty = false;
  function changed() { dirty = true; document.getElementById('save-state').textContent = 'You have unsaved changes.'; }
  function refresh() {
    const rows = [...container.children];
    rows.forEach((row, index) => {
      const label = row.querySelector('label'), area = row.querySelector('textarea');
      label.textContent = 'Day ' + (index + 1); label.htmlFor = area.id = 'day-' + index;
      row.querySelector('[data-move="-1"]').disabled = index === 0;
      row.querySelector('[data-move="1"]').disabled = index === rows.length - 1;
    });
    const matches = rows.length === Number(duration.value);
    document.getElementById('day-count').textContent = rows.length + ' itinerary days / ' + (duration.value || '0') + ' travel days' + (matches ? ' — ready.' : ' — add or remove days to match.');
    duration.setCustomValidity(matches ? '' : 'The itinerary day count must match this duration.');
    add.disabled = rows.length >= 60;
  }
  add.addEventListener('click', () => {
    const row = document.createElement('div');
    row.className = 'itinerary-day';
    row.innerHTML = '<div class="day-toolbar"><label></label><div><button type="button" data-move="-1" aria-label="Move day up">↑</button> <button type="button" data-move="1" aria-label="Move day down">↓</button> <button type="button" data-remove>Remove</button></div></div><textarea name="day" required maxlength="15000" rows="4"></textarea>';
    container.append(row); changed(); refresh(); row.querySelector('textarea').focus();
  });
  container.addEventListener('click', event => {
    const button = event.target.closest('button');
    if (!button) return;
    const row = button.closest('.itinerary-day');
    if (button.hasAttribute('data-remove')) {
      if (row.querySelector('textarea').value.trim() && !confirm('Remove this itinerary day?')) return;
      row.remove();
    } else if (button.dataset.move === '-1' && row.previousElementSibling) {
      container.insertBefore(row, row.previousElementSibling);
    } else if (button.dataset.move === '1' && row.nextElementSibling) {
      container.insertBefore(row.nextElementSibling, row);
    }
    changed(); refresh();
  });
  form.addEventListener('input', changed);
  duration.addEventListener('input', refresh);
  window.addEventListener('beforeunload', event => { if (dirty) { event.preventDefault(); event.returnValue = ''; } });
  form.addEventListener('submit', () => { dirty = false; });
  refresh();
})();

(() => {
 const input=document.getElementById('holiday-photo'),preview=document.getElementById('holiday-photo-preview');
 if(!input || !preview) return;
 let objectUrl;
 input.addEventListener('change',()=>{
   const file=input.files[0];
   input.setCustomValidity('');
   if(!file) return;
   if(file.size>5*1024*1024 || !['image/jpeg','image/png'].includes(file.type)){
     input.setCustomValidity('Choose a JPEG or PNG photo up to 5 MB.');
     input.reportValidity(); return;
   }
   if(objectUrl) URL.revokeObjectURL(objectUrl);
   objectUrl=URL.createObjectURL(file);preview.src=objectUrl;
 });
})();
