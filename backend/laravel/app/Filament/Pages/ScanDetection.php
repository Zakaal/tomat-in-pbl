<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use Illuminate\Support\Facades\Http;

class ScanDetection extends Page
{
    protected static ?string $navigationIcon = 'heroicon-o-camera';
    protected static ?string $navigationGroup = 'Detection';
    protected static string $view = 'filament.pages.scan-detection';

    public $image;
    public $result;

    public function detect()
    {
        $this->validate([
            'image' => 'required|image|max:2048', // Validasi ukuran dan tipe file
        ]);

        try {
            // Kirim gambar ke FastAPI
            $response = Http::attach(
                'file', file_get_contents($this->image->getRealPath()), $this->image->getClientOriginalName()
            )->post('http://127.0.0.1:8001/detect/');

            if ($response->successful()) {
                $this->result = $response->json()['classifications'][0] ?? ['error' => 'Tidak ada deteksi ditemukan.']; // Ambil hasil top-1
            } else {
                $this->result = ['error' => 'Deteksi gagal dilakukan.'];
            }
        } catch (\Exception $e) {
            $this->result = ['error' => 'Terjadi kesalahan: ' . $e->getMessage()];
        }
    }
}
