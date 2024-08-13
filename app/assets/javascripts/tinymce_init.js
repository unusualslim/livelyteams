document.addEventListener("DOMContentLoaded", () => {
  const hiddenField = document.getElementById('quill-content');
  console.log("Hidden Field:", hiddenField); // Debugging line

  if (hiddenField) {
    const noteContent = hiddenField.value;
    const htmlMarkup = noteContent;

    const quill = new Quill('#editor', {
      theme: 'snow',
      modules: {
        toolbar: [
          [{ 'header': '1' }, { 'header': '2' }, { 'font': [] }],
          [{ 'list': 'ordered'}, { 'list': 'bullet' }],
          ['bold', 'italic', 'underline'],
          [{ 'align': [] }],
          ['link', 'image']
        ]
      }
    });

    if (noteContent) {
      quill.clipboard.dangerouslyPasteHTML(htmlMarkup);
    }

    quill.on('text-change', () => {
      console.log("Quill content updated:", quill.root.innerHTML);
      hiddenField.value = quill.root.innerHTML;
    });
  } else {
    console.error("Element with ID 'quill-content' not found.");
  }
});
