<?php

namespace App\Http\Controllers;

use App\Models\Review;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ReviewController extends Controller
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
        $review = Review::all();
        // Lazy eager loading
        $review->load('user');
        return $review;
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        try {
            $validated = $request->validate([
                'place_name' => ['required'],
                'address' => ['required'],
                'rating' => ['required', 'max:5', 'min:0'],
                'review' => ['required'],
                'latitude' => ['min:-90', 'max:90'],
                'longitude' => ['min:-90', 'max:90']
            ]);

            $user = Auth::user();

            $review = $user->review()->create($validated);

            return $review;

        } catch (\Exception $e) {
            return  $e;
        }
    }
    public function create(Request $request){
        try{
            $validated = $request->validate([
                'nama_tempat'=>['required'],
                'alamat'=>['required'],
                'rating'=>['required'],
                'review'=>['required'],
                'latitude' => ['min:-90', 'max:90'],
                'longitude' => ['min:-90', 'max:90'],
                'photo'=>['required'],
            ]);
            $user = Auth::user();
            $review = $user->review()->create($validated);
            $this->status = 200;
            $this->data=[
                "message"=> "Create Review Success",
                "data" => $review,
            ];
            return response($this->data, $this->status);
        }catch(\Exception $e){
            $this->data=$e->getMessage();
            $this->status = 500;
            return response($this->data, $this->status);
        }
    }
    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Review  $review
     * @return \Illuminate\Http\Response
     */
    public function show(Review $review)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Review  $review
     * @return \Illuminate\Http\Response
     */
    public function edit(Review $review)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Review  $review
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Review $review)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Review  $review
     * @return \Illuminate\Http\Response
     */
    public function destroy(Review $review)
    {
        //
    }
}
