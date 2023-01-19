<?php
    session_start();
?>
<!DOCTYPE html>
<html>
    <head>
        <title>Gestionale parchi</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <link rel="StyleSheet" href="./CSS/style.css">
    </head>
    <body>
        <div class="divIntestazione">
            <h1 style="color: #4E3524;">
                Sistema informativo ambientale    
            </h1>
        </div>
        <br>
    <center>
        <form method="GET" action="index.php">

            <div class="divGenerale">
            <select name="nome_parco" class="bordiArrotondati">
                <?php
                    $ip = '127.0.0.1';
                    $username = 'root';
                    $pwd = '';
                    $database = 'parchi';
                    $connection = new mysqli($ip, $username, $pwd, $database);

                    if($connection->connect_error) {
                        die('C/errore: ' . $connection->connect_error);
                    }

                    $sql = 'SELECT nome, Regione FROM parco';
                    $result = $connection->query($sql);

                    if($result->num_rows > 0) {
                        while ($row = $result->fetch_assoc()) {
                            if($row['nome'] == $_GET['nome_parco']){
                                echo '<option selected value="' . $row['nome'] . '">' . $row['nome'] . ': ' . $row['Regione'] .  '</option>';
                            }
                            else {
                                echo '<option value="' . $row['nome'] . '">' . $row['nome'] . ': ' . $row['Regione'] .  '</option>';
                            }
                        }
                    }
                    echo "<br>";
                ?>
            </select>
            <input type="submit" class="btn btn-primary">
            </div>
        </form>

        <form method="GET">
        <div class="divGenerale">
        <?php
            if(isset($_REQUEST['nome_parco'])) {
                $_SESSION['parco_nome'] = $_REQUEST['nome_parco'];
                $ip = '127.0.0.1';
                $username = 'root';
                $pwd = '';
                $database = 'parchi';
                $connection = new mysqli($ip, $username, $pwd, $database);

                if($connection->connect_error) {
                    die('C/errore: ' . $connection->connect_error);
                }

                $sql = 'SELECT DISTINCT specie FROM animale WHERE parco="' . $_REQUEST['nome_parco'] .  '"';
                $result = $connection->query($sql);

                if($result->num_rows > 0) {
                    echo '<select name="nome_specie" class="bordiArrotondati">';
                    while ($row = $result->fetch_assoc()) {
                        echo '<option value="' . $row['specie'] . '">' . $row['specie'] . '</option>';
                    }
                    echo '</select>';
                    echo '<input type="submit" class="btn btn-primary">';
                }
                else {
                    echo '<p>Non sono state trovate speci</p>';
                }
            }
        ?>
        </div>
        </form>

        <?php
            if(isset($_REQUEST['nome_specie'])) {
                $ip = '127.0.0.1';
                $username = 'root';
                $pwd = '';
                $database = 'parchi';
                $connection = new mysqli($ip, $username, $pwd, $database);

                if($connection->connect_error) {
                    die('C/errore: ' . $connection->connect_error);
                }

                $sql = 'SELECT data_nascita FROM animale where specie="' . $_REQUEST['nome_specie'] . '" AND parco="' . $_SESSION['parco_nome'] . '"';
                $result = $connection->query($sql);

                if($result->num_rows > 0) {
                    $somma_eta = 0;
                    $numero = 0;
                    $data_oggi = new DateTime('00:00:00');
                    while ($row = $result->fetch_assoc()) {
                        $data_nascita = new DateTime($row['data_nascita']);
                        $diff = $data_oggi->diff($data_nascita);
                        $somma_eta += $diff->y;
                        $numero += 1;
                    }

                    $eta_media = $somma_eta / $numero;
                    $eta_media = floor($eta_media);
                    
                    echo "<h3>";
                    echo "Sono presenti " . $numero . " animali della specie " . $_REQUEST['nome_specie'] . " con un'eta' media di " . $eta_media . " anni";
                    echo "</h3>";
                }
                else {
                    //in teoria questo non puo' essere visualizzato dato che se non ci sono animali non appare nemmeno la possibilita' di selezionare un animale
                    //per sicurezza meglio comunque lasciarlo
                    echo '<p>Non sono stati trovati animali</p>';
                }
            }
        ?>
        </center>
    </body>
</html>