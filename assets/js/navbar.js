// document.addEventListener('DOMContentLoaded', () => {
//    // Mobile menu toggle
//    const mobileMenuButton = document.querySelector('.mobile-menu-button')
//    const mobileMenu = document.querySelector('.mobile-menu')
 
//    if (mobileMenuButton && mobileMenu) {
//      mobileMenuButton.addEventListener('click', () => {
//        mobileMenu.classList.toggle('hidden')
//        mobileMenu.classList.toggle('show')
//      })
//    }
 
//    // Sidebar dropdowns
//    document.querySelectorAll('[data-dropdown-toggle]').forEach(button => {
//      button.addEventListener('click', (e) => {
//        e.stopPropagation();
//        const dropdownId = button.getAttribute('data-dropdown-toggle');
//        const menu = document.querySelector([data-dropdown-menu,"${dropdownId}"]);
//        const icon = button.querySelector('.fa-chevron-down');
       
//        // Close other dropdowns
//        document.querySelectorAll('[data-dropdown-menu]').forEach(dropdown => {
//          if (dropdown !== menu) {
//            dropdown.classList.add('hidden');
//            const otherIcon = document.querySelector([data-dropdown-toggle,"${dropdown.getAttribute('data-dropdown-menu')}"] .fa-chevron-down);
//            if (otherIcon) otherIcon.style.transform = 'rotate(0deg)';
//          }
//        });
 
//        menu.classList.toggle('hidden');
//        if (icon) {
//          icon.style.transform = menu.classList.contains('hidden') ? 'rotate(0deg)' : 'rotate(180deg)';
//        }
//      });
//    });
 
//    // Close dropdowns when clicking outside
//    document.addEventListener('click', () => {
//      document.querySelectorAll('[data-dropdown-menu]').forEach(menu => {
//        menu.classList.add('hidden');
//        const icon = document.querySelector([data-dropdown-toggle,"${menu.getAttribute('data-dropdown-menu')}"] .fa-chevron-down);
//        if (icon) icon.style.transform = 'rotate(0deg)';
//      });
//    });
//  })