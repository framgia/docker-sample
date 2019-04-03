function submitFnc(){
  const form = document.getElementById("form");
  // 末尾に/が追加されるブラウザ対応
  if(form.action.slice(-1) == "/"){
    form.action = form.action.slice(0, -1);
  }

  const checkboxes = document.getElementsByName("id[]");
  

  let id_str = "/";
  checkboxes.forEach(checkbox => {
    if(checkbox.checked){
      if(id_str != "/"){id_str += ",";}
      id_str += checkbox.value;
    }
  });

  if(id_str != "/"){
    const method = document.getElementsByName("_method")[0];
    method.setAttribute('value', 'delete');
    form.appendChild(method);

    form.action += id_str;
  }
}
