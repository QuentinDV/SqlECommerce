<?php
// Connexion à la base de données
$mysqli = new mysqli("localhost", "root", "", "e-commerce");

if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}

// Inclure la bibliothèque Faker
require_once 'vendor/autoload.php';
$faker = Faker\Factory::create('fr_FR');

// Fonction pour insérer un utilisateur
function insertUser($mysqli, $faker) {
    $username = $faker->userName;
    $email = $faker->email;
    $password = password_hash('password123', PASSWORD_DEFAULT); // Hasher le mot de passe

    $query = "INSERT INTO user (username, email, password) VALUES ('$username', '$email', '$password')";
    if ($mysqli->query($query)) {
        $user_id = $mysqli->insert_id; // Récupérer l'ID de l'utilisateur inséré
        echo "Nouvel utilisateur créé avec succès: $username\n";
        return $user_id;
    } else {
        echo "Erreur lors de la création de l'utilisateur: " . $mysqli->error . "\n";
        return null;
    }
}

// Fonction pour insérer une adresse pour un utilisateur
function insertAddress($mysqli, $faker, $user_id) {
    $street = $faker->streetAddress;
    $city = $faker->city;
    $postal_code = $faker->postcode;

    $query = "INSERT INTO address (user_id, street, city, postal_code) VALUES ($user_id, '$street', '$city', '$postal_code')";
    if ($mysqli->query($query)) {
        echo "Nouvelle adresse créée pour l'utilisateur $user_id\n";
    } else {
        echo "Erreur lors de la création de l'adresse: " . $mysqli->error . "\n";
    }
}

// Fonction pour insérer un panier pour un utilisateur
function insertCart($mysqli, $user_id) {
    $query = "INSERT INTO cart (user_id) VALUES ($user_id)";
    if ($mysqli->query($query)) {
        $cart_id = $mysqli->insert_id; // Récupérer l'ID du panier inséré
        echo "Nouveau panier créé pour l'utilisateur $user_id\n";
        return $cart_id;
    } else {
        echo "Erreur lors de la création du panier: " . $mysqli->error . "\n";
        return null;
    }
}

// Fonction pour insérer une commande
function insertCommand($mysqli, $user_id, $cart_id) {
    $total = rand(20, 100); // Générer un total de commande aléatoire
    $query = "INSERT INTO command (user_id, cart_id, total) VALUES ($user_id, $cart_id, $total)";
    if ($mysqli->query($query)) {
        echo "Nouvelle commande créée pour l'utilisateur $user_id\n";
    } else {
        echo "Erreur lors de la création de la commande: " . $mysqli->error . "\n";
    }
}

function insertPhoto($mysqli, $faker, $user_id = null, $product_id = null) {
    $photo_url = $faker->imageUrl(640, 480, 'products', true, 'sample'); // URL d'image générée par Faker

    // Assurez-vous que les valeurs nulles sont correctement gérées
    $user_id_value = $user_id ? $user_id : 'NULL';
    $product_id_value = $product_id ? $product_id : 'NULL';

    $query = "INSERT INTO photo (user_id, product_id, photo_url) VALUES ($user_id_value, $product_id_value, '$photo_url')";
    
    if ($mysqli->query($query)) {
        echo "Photo ajoutée avec succès\n";
    } else {
        echo "Erreur lors de l'ajout de la photo: " . $mysqli->error . "\n";
    }
}

function insertRate($mysqli, $faker, $user_id, $product_id) {
    if (!$product_id) {
        echo "Aucun produit disponible pour l'évaluation.\n";
        return;
    }

    $rating = rand(1, 5); // Générer une note aléatoire entre 1 et 5
    $review = $faker->sentence; // Générer un avis aléatoire

    $query = "INSERT INTO rate (user_id, product_id, rating, review) VALUES ($user_id, $product_id, $rating, '$review')";
    
    if ($mysqli->query($query)) {
        echo "Évaluation ajoutée pour l'utilisateur $user_id et le produit $product_id\n";
    } else {
        echo "Erreur lors de l'ajout de l'évaluation: " . $mysqli->error . "\n";
    }
}

// Fonction pour insérer une méthode de paiement
function insertPayment($mysqli, $faker, $user_id) {
    $payment_method = $faker->randomElement(['credit_card', 'paypal', 'iban']);
    $payment_info = ($payment_method == 'credit_card') ? $faker->creditCardNumber : $faker->iban();

    $query = "INSERT INTO payment (user_id, payment_method, payment_info) VALUES ($user_id, '$payment_method', '$payment_info')";
    if ($mysqli->query($query)) {
        echo "Méthode de paiement ajoutée avec succès\n";
        return $mysqli->insert_id; // Retourner l'ID du paiement ajouté
    } else {
        echo "Erreur lors de l'ajout de la méthode de paiement: " . $mysqli->error . "\n";
        return null;
    }
}

function insertProduct($mysqli, $faker) {
    $name = $faker->word; // Correspond à la colonne `name` dans votre table
    $description = $faker->sentence; // Correspond à la colonne `description`
    $price = $faker->randomFloat(2, 5, 500); // Générer un prix entre 5 et 500
    $stock = rand(1, 100); // Ajoutez une valeur pour le stock

    $query = "INSERT INTO product (name, description, price, stock) VALUES ('$name', '$description', $price, $stock)";

    if ($mysqli->query($query)) {
        $product_id = $mysqli->insert_id; // Récupérer l'ID du produit inséré
        echo "Produit ajouté avec succès: $name\n";
        return $product_id;
    } else {
        echo "Erreur lors de l'ajout du produit: " . $mysqli->error . "\n";
        return null;
    }
}

// Fonction pour insérer une facture
function insertInvoices($mysqli, $faker, $user_id, $command_id, $payment_id) {
    $total = rand(20, 100); // Générer un total de facture aléatoire
    $created_date = $faker->date; // Générer une date aléatoire pour la facture

    $query = "INSERT INTO invoices (user_id, command_id, total, created_date, payment_id) 
              VALUES ($user_id, $command_id, $total, '$created_date', $payment_id)";
    
    if ($mysqli->query($query)) {
        echo "Facture ajoutée pour l'utilisateur $user_id et la commande $command_id\n";
    } else {
        echo "Erreur lors de l'ajout de la facture: " . $mysqli->error . "\n";
    }
}

// Fonction pour insérer des articles dans le panier
function insertProductCart($mysqli, $faker, $cart_id, $product_ids) {
    foreach ($product_ids as $product_id) {
        $quantity = rand(1, 5); // Quantité aléatoire entre 1 et 5 pour chaque produit dans le panier

        $query = "INSERT INTO `product cart` (cart_id, product_id, quantity) 
                  VALUES ($cart_id, $product_id, $quantity)";
        
        if ($mysqli->query($query)) {
            echo "Produit ajouté au panier avec succès: cart_id=$cart_id, product_id=$product_id, quantity=$quantity\n";
        } else {
            echo "Erreur lors de l'ajout du produit au panier: " . $mysqli->error . "\n";
        }
    }
}

// Insérer des produits au début
$product_ids = [];
for ($i = 0; $i < 10; $i++) { // Ajouter 10 produits
    $product_id = insertProduct($mysqli, $faker);
    if ($product_id) {
        $product_ids[] = $product_id;
    }
}

// Insérer des factures pour chaque commande
for ($i = 0; $i < 10; $i++) {
    $user_id = insertUser($mysqli, $faker);
    if ($user_id) {
        insertAddress($mysqli, $faker, $user_id);
        $cart_id = insertCart($mysqli, $user_id);
        if ($cart_id) {
            insertCommand($mysqli, $user_id, $cart_id);
        }
        insertPhoto($mysqli, $faker, $user_id, $product_ids[array_rand($product_ids)]);

        // Insérer une méthode de paiement et récupérer l'ID
        $payment_id = insertPayment($mysqli, $faker, $user_id);
        if ($payment_id) {
            // Assurer que la facture est liée à une méthode de paiement valide
            insertInvoices($mysqli, $faker, $user_id, $cart_id, $payment_id);
        }

        insertRate($mysqli, $faker, $user_id, $product_ids[array_rand($product_ids)]);

        // Ajouter des produits aléatoires au panier
        insertProductCart($mysqli, $faker, $cart_id, $product_ids);
        
    }
}

$mysqli->close();
?>
