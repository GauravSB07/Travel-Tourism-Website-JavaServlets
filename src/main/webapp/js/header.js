document.addEventListener("DOMContentLoaded", function () {


    /* =====================================================
       SEARCH
       ===================================================== */

    const searchIcon =
            document.getElementById("headerSearchIcon");

    const searchForm =
            document.getElementById("headerSearchForm");


    if (searchIcon && searchForm) {

        searchIcon.addEventListener("click", function (event) {

            event.preventDefault();
            event.stopPropagation();

            searchForm.classList.toggle("active");


            if (searchForm.classList.contains("active")) {

                const input =
                        searchForm.querySelector("input");

                if (input) {

                    setTimeout(function () {

                        input.focus();

                    }, 100);

                }

            }

        });


        /* Close search when clicking outside */

        document.addEventListener("click", function (event) {

            if (!searchForm.contains(event.target)
                    && !searchIcon.contains(event.target)) {

                searchForm.classList.remove("active");

            }

        });


        /* Prevent empty search */

        searchForm.addEventListener("submit", function (event) {

            const input =
                    searchForm.querySelector("input");

            if (!input || input.value.trim() === "") {

                event.preventDefault();

                if (input) {
                    input.focus();
                }

            }

        });

    }



    /* =====================================================
       USER DROPDOWN
       ===================================================== */

    const userMenu =
            document.querySelector(".user-menu");

    const userMenuLink =
            document.getElementById("userMenuLink");


    if (userMenu && userMenuLink) {


        userMenuLink.addEventListener("click", function (event) {

            event.preventDefault();
            event.stopPropagation();


            const isOpen =
                    userMenu.classList.toggle("open");


            userMenuLink.setAttribute(
                    "aria-expanded",
                    isOpen ? "true" : "false"
            );

        });


        /* Close dropdown when clicking outside */

        document.addEventListener("click", function (event) {

            if (!userMenu.contains(event.target)) {

                userMenu.classList.remove("open");

                userMenuLink.setAttribute(
                        "aria-expanded",
                        "false"
                );

            }

        });


        /* Close dropdown with Escape */

        document.addEventListener("keydown", function (event) {

            if (event.key === "Escape") {

                userMenu.classList.remove("open");

                userMenuLink.setAttribute(
                        "aria-expanded",
                        "false"
                );

            }

        });

    }

});