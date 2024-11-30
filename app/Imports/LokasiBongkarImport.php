<?php

namespace App\Imports;

use App\Models\LokasiBongkar;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;

class LokasiBongkarImport implements ToModel, WithHeadingRow
{
    public function model(array $row)
    {
        return new LokasiBongkar([
            'name' => $row['name'],
            'address' => $row['address'],
            'kotas_id' => $row['kotas_id'],
            'coordinate' => $row['coordinate'],
            'kategori_lokasi_id' => $row['kategori_lokasi_id'],
        ]);
    }
}
