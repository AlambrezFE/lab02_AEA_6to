<!DOCTYPE html>
<html>
<head>
    <title>GIF Extractor</title>
</head>
<body>
    <h3>GIF Extractor</h3>
    <form method="get">
        <input type="text" name="gifId" placeholder="Enter GIF ID" />
        <button type="submit">Get GIF</button>
    </form>

    <?php
    if (isset($_GET['gifId'])) {
        $gifId = intval($_GET['gifId']);
        $apiUrl = getenv('API_URL') . "/$gifId";
        $response = file_get_contents($apiUrl);
        $data = json_decode($response, true);
        if (isset($data['url'])) {
            echo "<img src='{$data['url']}' width='500' height='500' />";
        } else {
            echo "GIF not found";
        }
    }
    ?>
</body>
</html>

