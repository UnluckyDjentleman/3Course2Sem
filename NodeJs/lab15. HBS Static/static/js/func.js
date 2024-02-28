addContact=()=>{
    const nameContact=document.getElementsByName("name")[0].value;
    const phoneContact=document.getElementsByName("phone")[0].value;
    fetch('/add',{
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({name: nameContact, phone: phoneContact})
    }).then(()=>window.location.href='http://localhost:3000/')
}

updateContact=()=>{
    const id = document.querySelector('.form').getAttribute('data-key');
    const nameContact=document.getElementsByName("name")[0].value;
    const phoneContact=document.getElementsByName("phone")[0].value;
    fetch(`/update/${id}`,{
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({name: nameContact, phone: phoneContact})
    }).then(()=>window.location.href='http://localhost:3000/')
}

deleteContact=()=>{
    const id = document.querySelector('.form').getAttribute('data-key');
    fetch(`/delete/${id}`,{
        method: 'POST',
        headers: { 'Content-Type': 'application/json' }
    }).then(()=>window.location.href='http://localhost:3000/')
}

checkTelephone=(number)=>{
    return new RegExp(/^\+[1-9]\d{9,11}$/g).test(number)
}