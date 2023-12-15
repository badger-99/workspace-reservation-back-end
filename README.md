<h3 align="center"><b>Workspace</b></h3>

<a name="readme-top"></a>

# 📗 Table of Contents

- [📗 Table of Contents](#-table-of-contents)
- [📖 Workspace ](#-workspace-)
    - [Links](#links)
  - [🛠 Built With ](#-built-with-)
    - [Tech Stack ](#tech-stack-)
    - [Key Features ](#key-features-)
  - [💻 Getting Started ](#-getting-started-)
    - [Prerequisites](#prerequisites)
  - [Setup](#setup)
    - [Install](#install)
    - [Run tests](#run-tests)
    - [Usage](#usage)
  - [👥 Authors ](#-authors-)
  - [🔭 Future Features ](#-future-features-)
  - [🤝 Contributing ](#-contributing-)
  - [⭐️ Show your support ](#️-show-your-support-)
  - [🙏 Acknowledgments ](#-acknowledgments-)
  - [📝 License ](#-license-)


# 📖 Workspace <a name="about-project"></a>

The **Workspace** app is a fullstack project that allows coworking space owners to manage their space and users to book a rooms. It is a Ruby on Rails app with a PostgreSQL database for the backend and React/Redux for the frontend.

This repository contains the backend part of the project. The frontend part can be found [here](https://github.com/Zilola-Nazarova/workspace-reservation-front-end)

The project Kanban board can be found [here](https://github.com/users/badger-99/projects/7/views/1)

The initial state of Kanban board can be found [here](https://github.com/badger-99/workspace-reservation-back-end/issues/12)

Group consists of 4 students:
1 - [Alfred Makongoro](https://github.com/badger-99)
2 - [Zilola Nazarova](https://github.com/Zilola-Nazarova)
3 - [Abdul Wahab Hussain](https://github.com/Abdulwhbhussain)
4 - [Javier Hernandez](https://github.com/wickathou)

### Links <a name="links"></a>

- [**Deployed frontend**](https://zilola-nazarova.github.io/workspace-reservation-front-end)

- [**API Documentation**](https://workspace-reservation.onrender.com/api-docs/index.html)

- [**ERD**](https://drawsql.app/teams/my-team-1117/diagrams/final-capstone)

- **Base URL** `https://workspace-reservation.onrender.com`

## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

- **[Ruby](https://www.ruby-lang.org/en/)**
- **[Ruby on Rails](https://rubyonrails.org/)**
- **[PostgreSQL](https://www.postgresql.org/)**
- **[RSpec](https://rspec.info/)**

### Key Features <a name="key-features"></a>

- **User authentication**
- **User authorization**
- **User profiles**
- **User roles**
- **User bookings**

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## 💻 Getting Started <a name="getting-started"></a>

To get a local copy up and running, follow these steps.

### Prerequisites

In order to run this project you need:

- GitHub account;
- Git installed on your OS;
- VSCode (or another code editor);
- modern browser (supporting HTML5 and CSS3) is highly recommended;
- [Ruby](https://www.ruby-lang.org/en/documentation/installation/) installed;
- [Ruby on Rails](https://gorails.com/guides) installed;
- [Node.js and npm](https://nodejs.org/) installed.

## Setup

Clone this repository to your desired folder:

    git clone git@github.com:badger-99/workspace-reservation-back-end.git

### Install

 Install the required gems

    bundle install

Set your username and password to corresponding fields in [database.yml](./config/database.yml).

Create the database by running the command

    rails db:create

Run the migrations

    rails db:migrate

### Run tests

There are separated into several folders, and some are quite large so running all of them at once may cause some to fail. We highly recommend that you run the tests by their colders using the following commands:
-  _Controller Specs_

    >`rspec ./spec/requests/api/v1/registrations_controller_spec.rb`

    >`rspec ./spec/requests/api/v1/reservations_controller_spec.rb`

    >`rspec ./spec/requests/api/v1/sessions_controller_spec.rb`

    >`rspec ./spec/requests/api/v1/workspaces_controller_spec.rb`


- _Model Specs_

    >`rspec ./spec/models/reservation_spec.rb`

    >`rspec ./spec/models/user_spec.rb`

    >`rspec ./spec/models/workspace_spec.rb`

### Usage

This is a back-end project. You will need either [this front-end project](https://github.com/Zilola-Nazarova/workspace-reservation-front-end) or the [api-docs](https://workspace-reservation.onrender.com/api-docs/index.html) to interact with it, or you can build your own front-end project. When working with local server, you will need to:
1. Delete `credentials.yml.enc` and generate new credentials/mater.key pair by running `rails credentials:edit`
2. Start the server with 

    rails s

If working locally, check `./config/environments/development.rb` and `./config/environments/test.rb` and make sure that `Rails.application.routes.default_url_options` reflects the port that the local server is running from (e.g. http://localhost:3000 ) so that image uploads can work.

If using the api-docs, make sure to set the local server in `./swagger/v1/swagger.yaml` before navigating to the api-docs page at `http://{your_default_url}/api-docs`, or refresh the page if you make the change after navigting there.

If you are interested in how to set up your own [Amzon S3 bucket](https://aws.amazon.com/s3/) to use for uploads you can refer to [this guide](https://medium.com/@taylor_8332/active-storage-aws-s3-and-render-a-step-by-step-setup-guide-fd77824bc010) by [Taylor Huffman](https://medium.com/@taylor_8332). The only deviation from the instructions is that we removed `./config/storage.yml` and set the storage configurations in environment-specific files in the `./config/storage` directory to prevent the development code from trying to access the S3 bucket.

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## 👥 Authors <a name="authors"></a>

👤 **Zilola Nazarova**

- GitHub: [@Zilola-Nazarova](https://github.com/Zilola-Nazarova)
- LinkedIn: [in/NazarovaZi](https://www.linkedin.com/in/zilola-nazarova)
- Twitter: [@NazarovaZi](https://twitter.com/NazarovaZi)

👤 **Alfred Makongoro**

- GitHub: [@badger-99](https://github.com/badger-99)
- X: [@AlfredMkg](https://twitter.com/AlfredMkg)
- LinkedIn: [in/alfredmkg](https://www.linkedin.com/in/alfredmkg)

👤 **Abdul Wahab Hussain**

- GitHub: [@githubhandle](https://github.com/Abdulwhbhussain)
- Twitter: [@twitterhandle](https://twitter.com/AbdulWhbHussain)
- LinkedIn: [LinkedIn](https://www.linkedin.com/in/abdulwhbhussain)

👤 **Javier Hernandez**

- GitHub: [@wickathou](https://github.com/wickathou)
- LinkedIn: [@javierjhm](https://www.linkedin.com/in/javierjhm/)
- Portfolio: [@End Design Co.](https://enddesign.co/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## 🔭 Future Features <a name="future-features"></a>

- [ ] **Add more tests**
- [ ] **Add time slots to reservations**
- [ ] **Add payment system**
- [ ] **Add additional user roles**

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## ⭐️ Show your support <a name="support"></a>

If you like this project just star it!

<p align="right">(<a href="#readme-top">back to top</a>)</p>


## 🙏 Acknowledgments <a name="acknowledgements"></a>

We would like to thank [Microverse](https://www.microverse.org/) for the knowledge and skills we have acquired in the Full-Stack Development Program, and for providing the resources that facilitated out learning..

We are grateful to all previous project reviewers for their advice. Thanks to them we were able to make improvements and increase the quality of our work.

We would like to thank [Murat Korkmaz](https://www.behance.net/muratk) for making the [Vespa - Responsive Redesign](https://www.behance.net/gallery/26425031/Vespa-Responsive-Redesign) details, on which this project was based, available through the [Creative Commons license of the design](https://creativecommons.org/licenses/by-nc/4.0/).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 📝 License <a name="license"></a>

This project is [MIT](./LICENSE) licensed.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
