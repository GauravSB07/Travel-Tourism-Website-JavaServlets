(() => {
 const dialog=document.querySelector('.holiday-lightbox');
 const photos=[...document.querySelectorAll('.holiday-gallery-photo')];
 if(!dialog || !dialog.showModal || !photos.length)return;
 const image=dialog.querySelector('img'),caption=dialog.querySelector('.holiday-lightbox-caption'),counter=dialog.querySelector('[aria-live]');
 let current=0,opener;
 function show(i){current=(i+photos.length)%photos.length;image.src=photos[current].href;image.alt=photos[current].querySelector('img').alt;caption.textContent=photos[current].dataset.caption||'';counter.textContent=(current+1)+' / '+photos.length;}
 photos.forEach((photo,i)=>photo.addEventListener('click',event=>{
  if(event.ctrlKey||event.metaKey||event.shiftKey||event.altKey)return;
  event.preventDefault();opener=photo;show(i);dialog.showModal();document.body.classList.add('holiday-viewer-open');
 }));
 dialog.querySelector('[data-close]').addEventListener('click',()=>dialog.close());
 dialog.querySelectorAll('[data-direction]').forEach(button=>{button.hidden=photos.length<2;button.addEventListener('click',()=>show(current+Number(button.dataset.direction)));});
 dialog.addEventListener('keydown',event=>{if(event.key==='ArrowRight'||event.key==='ArrowLeft'){event.preventDefault();show(current+(event.key==='ArrowRight'?1:-1));}});
 dialog.addEventListener('click',event=>{if(event.target===dialog)dialog.close();});
 dialog.addEventListener('close',()=>{document.body.classList.remove('holiday-viewer-open');if(opener)opener.focus();});
})();