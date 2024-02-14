['turbo:before-stream-render'].forEach((eventName) => {
  document.addEventListener(eventName, (e) => {
    const stream = e.detail.newStream;

    if (stream.target == 'created_client_credential') {
      const createdClientID = stream.querySelector('template').content.querySelector('input[id$="_client_id"]').value;
      const createdClientFullName = stream.querySelector('template').content.querySelector('input[id$="_client_full_name"]').value;

      const clientIDInput = document.querySelector('input[id$="_client_id"]');
      const clientFullNameInput = document.querySelector('input[id="client"]');

      clientIDInput.value = createdClientID;
      clientFullNameInput.value = createdClientFullName;
      clientIDInput.setAttribute('data-client-id', createdClientFullName);
    }
  });
})

document.addEventListener('turbo:load', (e) => {
  const clientIDInput = document.querySelector('input[id$="_client_id"]');
});


