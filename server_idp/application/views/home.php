<!-- <!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Page</title>

    <style>
        .button {
            background-color: #4CAF50;
            /* Hijau */
            border: none;
            color: green;
            padding: 10px 10px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            margin: 4px 2px;
            cursor: pointer;
        }

        .button1 {
            background-color: green;
            color: white;
            border: 2px solid #e7e7e7;
        }

        td {
            text-align: center;
            vertical-align: middle;
        }
    </style>

</head>

<body>
    <h1>Home eTicket</h1>
    <a href="<?= base_url('/home/halaman_transaksi') ?>"><button class="button button1">Daftar Transaksi</button></a>
    <a href="<?= base_url('/home/halaman_rekap') ?>"><button class="button button1">Rekap Transaksi</button></a>
</body>

</html> -->


<!DOCTYPE html>
<html lang="en">

<head>
    <style>
        * {
            margin: 0;
            padding: 0;

        }

        body {
            background-color: #eff1f2;
            font-family: sans-serif;
        }

        .content {
            grid-area: content;
        }

        .sidebar {
            grid-area: sidebar;
            background: linear-gradient(to right, rgba(200, 107, 142, 1), rgba(218, 105, 250, 1),
                    rgba(110, 125, 253, 1));
            justify-content: center;
        }

        .footer {
            grid-area: footer;
            background: white;
        }

        .container {
            font-size: 1.5em;
            width: 100%;
            height: 100;
            height: 100vh;
            display: grid;
            grid-template-areas: "sidebar""content""footer";
            grid-template-columns: 1fr;
            grid-template-rows: 130px 800px 250px;

        }

        .content,
        .sidebar,
        .footer {
            padding: 1em;
        }

        nav ul {
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: space-between;
            text-align: center;
        }

        nav li {
            list-style: none;
            padding: 1em 0;
        }


        li {
            color: white;
            font-weight: 700;
            opacity: 0.6;
            text-decoration: none;
            transition: 0.3s;
        }

        nav li a:hover {
            opacity: 1;
        }

        .hero {
            max-width: 90 px;
            margin: 0 auto;
            text-align: center;
        }

        .hero img {
            width: 200px;
        }

        .hero h1 {
            font-size: 2em;
            font-weight: 300;
            color: #373046;
        }

        .hero p {
            font-weight: 300;
            line-height: 1.3em;
            color: #98aBad;
        }

        .action-btn {
            display: inline-block;
            text-decoration: none;
            color: white;
            font-weight: 700;
            background: #567bfb;
            padding: 0.5em 2em;
            border-radius: 60px;
            margin: 1em 0;
            transition: 0.3s;
        }

        footer ul {
            max-width: 640px;
            margin: 2em auto;
            padding: 0;
            text-align: center;
            display: flex;
            flex-direction: row;

        }

        footer ul li {
            list-style: none;
            align-self: flex-end;
        }

        footer ul li a {
            text-decoration: none;
            color: #c1c6ce;
        }

        footer ul li img {
            width: 30%;
        }

        footer p {
            font-size: 0.8em;
        }

        @media (min-width: 1040px) {
            .container {
                grid-template-areas: "sidebar content""sidebar footer";
                grid-template-rows: 1fr auto;
                grid-template-columns: 300px 1f;
            }

            nav ul {
                display: flex;
                justify-content: space-between;
                flex-direction: column;
            }

            .sidebar {
                background: linear-gradient(rgba(200, 107, 142, 1), rgba(218, 105, 250, 1),
                        rgba(110, 125, 253, 1));
                padding-top: 10em;
            }

            .hero {
                text-align: left;
                margin: 7em 0;
            }

            .hero img {
                width: 200px;
                float: right;
            }

            .hero h1 {
                font-size: 3em;
            }

            .hero p {
                width: 60%;
            }

        }
    </style>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Data Rekapitulasi</title>
</head>

<body>
    <div class="container">
        <div class="sidebar">
            <!-- <nav>
                <ul>
                    <li>D</li>
                    <li>A</li>
                    <li>T</li>
                    <li>A</li>
                </ul>
            </nav> -->
        </div>
        <main class="content">
            <section class="hero">
                <div class="hero-content">
                    <h1>eHotel</h1><br></h2>Transaksi & Rekapitulasi</h2><br><br>

                    <a href="<?= base_url('/home/halaman_transaksi') ?>" class="action-btn">Daftar Transaksi</a>
                    <a href="<?= base_url('/home_tahun2024/halaman_rekap') ?>" class="action-btn">Rekap Transaksi</a>

                    <a href="<?= base_url('/login2') ?>" class="action-btn"> <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-wrench-adjustable" viewBox="0 0 16 16">
                            <path d="M16 4.5a4.492 4.492 0 0 1-1.703 3.526L13 5l2.959-1.11c.027.2.041.403.041.61Z" />
                            <path d="M11.5 9c.653 0 1.273-.139 1.833-.39L12 5.5 11 3l3.826-1.53A4.5 4.5 0 0 0 7.29 6.092l-6.116 5.096a2.583 2.583 0 1 0 3.638 3.638L9.908 8.71A4.49 4.49 0 0 0 11.5 9Zm-1.292-4.361-.596.893.809-.27a.25.25 0 0 1 .287.377l-.596.893.809-.27.158.475-1.5.5a.25.25 0 0 1-.287-.376l.596-.893-.809.27a.25.25 0 0 1-.287-.377l.596-.893-.809.27-.158-.475 1.5-.5a.25.25 0 0 1 .287.376ZM3 14a1 1 0 1 1 0-2 1 1 0 0 1 0 2Z" />
                        </svg> Engineering</a>
                </div>
            </section>
    </div>

    </div>
</body>

</html>