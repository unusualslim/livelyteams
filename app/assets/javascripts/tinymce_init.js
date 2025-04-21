document.addEventListener("DOMContentLoaded", () => {
  // Get both required elements
  const hiddenField = document.getElementById('quill-content');
  const editorEl = document.getElementById('editor');

  // Only initialize Quill if both elements are found
  if (!hiddenField || !editorEl) {
    return; // Exit the script gracefully
  }

  // If both elements are present, proceed with initialization
  const noteContent = hiddenField.value;
  const htmlMarkup = noteContent;

  const quill = new Quill(editorEl, {
    theme: 'snow',
    modules: {
      toolbar: [
        [{ 'header': '1' }, { 'header': '2' }, { 'font': [] }],
        [{ 'list': 'ordered' }, { 'list': 'bullet' }],
        ['bold', 'italic', 'underline'],
        [{ 'align': [] }],
        ['link', 'image']
      ]
    }
  });

  // If there is existing content, paste it into the editor
  if (noteContent) {
    quill.clipboard.dangerouslyPasteHTML(htmlMarkup);
  }

  // Update the hidden field whenever the editor content changes
  quill.on('text-change', () => {
    hiddenField.value = quill.root.innerHTML;
  });
});

