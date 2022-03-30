<?php

use Illuminate\Support\Facades\Http;

function predictTextIsSpam(string $txt) : bool {
  /*
  Fungsi ini digunakan untuk melakukan request ke AI node untuk mendeteksi input
  yang diberikan merupakan text spam ataupun tidak.
  */

  $txt = trim($txt);
  
  if (strlen($txt) == 0) {
    return False;
  }
  
  $data = [
    "text" => $txt
  ];
  $response = Http::post(env("AI_HOST").":".env("AI_PORT")."/", $data);
  if (!$response->successful() || $response->status() != 200) {
    throw new \Exception("Gagal dalam melakukan request ke AI node");
  }
  
  $isSpam = $response["is_spam"];

  return $isSpam;
}