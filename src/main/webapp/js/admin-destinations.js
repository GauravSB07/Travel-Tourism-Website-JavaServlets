(() => {
 const workspace=document.querySelector('.tour-admin .workspace');
 if(!workspace) return;
 const cards=[...workspace.querySelectorAll(':scope > .card')];
 const labels=['Essentials','Package details','Itinerary','Hotels','Photos'];
 const nav=document.createElement('div');
 nav.className='destination-editor-tabs';nav.setAttribute('role','tablist');nav.setAttribute('aria-label','Destination editor sections');
 const buttons=[];
 cards.forEach((card,i)=>{
   card.id='destination-section-'+i;card.setAttribute('role','tabpanel');card.setAttribute('aria-labelledby','destination-tab-'+i);
   const heading=card.querySelector('.card-header');if(heading)heading.dataset.step=String(i+1).padStart(2,'0');
   const button=document.createElement('button');button.type='button';button.id='destination-tab-'+i;
   button.textContent=labels[i] || 'Section '+(i+1);button.setAttribute('role','tab');button.setAttribute('aria-controls',card.id);
   nav.append(button);buttons.push(button);
 });
 const key='destination-editor:'+location.search;
 function select(index,focus=false) {
   cards.forEach((card,i)=>{card.hidden=i!==index;buttons[i].setAttribute('aria-selected',String(i===index));buttons[i].tabIndex=i===index?0:-1;});
   try{sessionStorage.setItem(key,String(index));}catch(e){}
   if(focus)buttons[index].focus();
 }
 if(cards.length>1) {
   workspace.insertBefore(nav,cards[0]);
   buttons.forEach((button,i)=>{
     button.addEventListener('click',()=>select(i));
     button.addEventListener('keydown',e=>{
       let next=i;
       if(e.key==='ArrowRight')next=(i+1)%buttons.length;
       else if(e.key==='ArrowLeft')next=(i+buttons.length-1)%buttons.length;
       else if(e.key==='Home')next=0;else if(e.key==='End')next=buttons.length-1;else return;
       e.preventDefault();select(next,true);
     });
   });
   let initial=0;try{initial=Number(sessionStorage.getItem(key)||0);}catch(e){}
   select(Number.isInteger(initial)&&initial>=0&&initial<cards.length?initial:0);
 }
 const danger=workspace.querySelector('.danger-zone');
 if(danger){const details=document.createElement('details');details.className='destination-delete';
 const summary=document.createElement('summary');summary.textContent='Delete this destination';details.append(summary);
 while(danger.firstChild)details.append(danger.firstChild);danger.append(details);}
 const changed=new Set();
 workspace.addEventListener('input',e=>{if(e.target.form)changed.add(e.target.form);});
 workspace.addEventListener('change',e=>{if(e.target.form)changed.add(e.target.form);});
 workspace.addEventListener('submit',e=>{
   if(e.defaultPrevented)return;
   if([...changed].some(f=>f!==e.target)&&!confirm('You have unsaved changes in another section. Continue without saving those changes?')){e.preventDefault();return;}
   changed.clear();
 });
 window.addEventListener('beforeunload',e=>{if(changed.size){e.preventDefault();e.returnValue='';}});
})();
(() => {
 const input=document.getElementById('destination-cover-file');
 const preview=document.getElementById('destination-cover-preview');
 const placeholder=document.getElementById('destination-cover-placeholder');
 if(!input||!preview)return;
 let objectUrl;
 input.addEventListener('change',()=>{
   input.setCustomValidity('');
   const file=input.files[0];if(!file)return;
   if(file.size>5*1024*1024||!['image/jpeg','image/png'].includes(file.type)){
     input.setCustomValidity('Choose a JPEG or PNG photo up to 5 MB.');input.reportValidity();return;
   }
   if(objectUrl)URL.revokeObjectURL(objectUrl);
   objectUrl=URL.createObjectURL(file);preview.src=objectUrl;preview.hidden=false;
   if(placeholder)placeholder.hidden=true;
 });
 const gallery=document.getElementById('destination-gallery-file');
 if(gallery)gallery.addEventListener('change',()=>{
   gallery.setCustomValidity('');
   const file=gallery.files[0];if(file&&(file.size>5*1024*1024||!['image/jpeg','image/png'].includes(file.type))){
     gallery.setCustomValidity('Choose a JPEG or PNG photo up to 5 MB.');gallery.reportValidity();
   }
 });
})();
