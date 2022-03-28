<?php

namespace App\Http\Controllers;

use App\Models\Komentar;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class KomentarController extends Controller
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
        //
        $komentar = Komentar::all();
        // Lazy eager loading
        $komentar->load('user');
        return $komentar;
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create(Request $request)
    {
        try{
            $validated = $request->validate([
                'komentar' =>['required'],
                'review_id' =>['required']
            ]);
            $user = Auth::user();
            $komentar = $user->komentar()->create($validated);
            $this->status = 200;
            $this->data=[
                "message"=> "Create Komentar Success",
                "data"=> $komentar
            ];
            return response($this->data, $this->status);
        }catch(\Exception $e){
            $this->data=$e->getMessage();
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
     * @param  \App\Models\Komentar  $komentar
     * @return \Illuminate\Http\Response
     */
    public function show(Komentar $komentar)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Komentar  $komentar
     * @return \Illuminate\Http\Response
     */
    public function edit(Komentar $komentar)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Komentar  $komentar
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Komentar $komentar)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Komentar  $komentar
     * @return \Illuminate\Http\Response
     */
    public function destroy(Komentar $komentar)
    {
        //
    }

    public function getallkomentar_byreviewid(int $review_id)
    {
        $komentar = Komentar::where(array('review_id' => $review_id))->get();
        // Lazy eager loading
        $komentar->load('user');
        $this->status = 200;
        $this->data=[
            "message"=> "Get Komentar Success",
            "data" => $komentar,
        ];
        return response($this->data, $this->status);
    }
}
