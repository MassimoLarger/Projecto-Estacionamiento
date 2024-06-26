document.addEventListener('DOMContentLoaded', function() {
  var buttons = document.querySelectorAll('.campus-button');
  buttons.forEach(function(button) {
      button.addEventListener('click', function() {
          var dropdownId = this.getAttribute('data-dropdown');
          var dropdown = document.getElementById(dropdownId);
          if (dropdown.style.display === 'block') {
              dropdown.style.display = 'none';
          } else {
              dropdown.style.display = 'block';
          }
      });
  });

  window.addEventListener('click', function(event) {
      if (!event.target.matches('.campus-button')) {
          var dropdowns = document.querySelectorAll('.dropdown-content');
          dropdowns.forEach(function(dropdown) {
              if (dropdown.style.display === 'block') {
                  dropdown.style.display = 'none';
              }
          });
      }
  });
});
