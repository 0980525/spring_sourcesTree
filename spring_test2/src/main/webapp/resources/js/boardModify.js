console.log("boardModify js in");

document.addEventListener('click', (e)=>{
    if(e.target.classList.contains('file-x')) {
        let uuid = e.target.dataset.uuid;
        console.log(uuid);
        removeFileToServer(uuid).then(result => {
            if(result === "1") {
                alert("파일 삭제 성공");
                e.target.closest('li').remove();
            }
        })
    }
})

async function removeFileToServer(uuid) {
    try {
        const url = "/board/file/"+uuid;
        const config ={
            method : "delete"
        }
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;
    } catch (error) {
        console.log(error);
    }
}