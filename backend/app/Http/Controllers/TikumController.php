<?php

namespace App\Http\Controllers;

use App\Models\Tikum;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class TikumController extends Controller
{
    public function __construct()
    {
        $this->status = 200;
        $this->data = [];
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $tikum = Tikum::all();
        $this->status = 200;
        $this->data = $tikum;
        return response($this->data,$this->status);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {
        try {
            // Check on ERD of TIkum not all required
            $validated = $request->validate([
                'tempat_tujuan'=>['required'],
                'tempat_kumpul'=>['required'],
                'waktu_kumpul'=>['required'],
                'link_group'=>[],
                'deskripsi'=>[]
            ]);

            $user = Auth::user();

            $tikum = $user->tikum()->create($validated);
            $this->status = 200;
            $this->data = [
                "message"=> "Create Tikums Success",
                "data" => $tikum,
            ];
            return response($this->data,$this->status);

        } catch (\Exception $e) {
            $this->data = $e->getMessage();
            $this->status = 500;
            return response($this->data, $this->status);
        }
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Tikum  $tikum
     * @return \Illuminate\Http\Response
     */
    public function show(Tikum $tikum)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Tikum  $tikum
     * @return \Illuminate\Http\Response
     */
    public function edit(Tikum $tikum)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Tikum  $tikum
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Tikum $tikum)
    {
        //
    }

    /**
     * Remove Tikum that user have
     *
     * @param  int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy(int $id)
    {
        try {
            $user = Auth::user();
            $komentar = Tikum::find($id);
            if ($komentar->user_id != $user->id) {
                $this->status = 403;
                return response($this->data, $this->status);
            }

            $komentar->delete();
            $this->status = 200;
            $this->data = $komentar;
            return response($this->data, $this->status);

        } catch (\Exception $e) {
            $this->data = $e->getMessage();
            $this->status = 500;
            return response($this->data, $this->status); 
        }
    }
}
