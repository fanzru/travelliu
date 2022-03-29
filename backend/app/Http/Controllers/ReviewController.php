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
    public function create(Request $request){
        try{
            $validated = $request->validate([
                'nama_tempat'=>['required'],
                'alamat'=>['required'],
                'rating'=>['required', 'max:5', 'min:0'],
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
     * @param  string  $id
     */
    public function show(int $id)
    {
        $review = Review::where(array('id' => $id))->get();
        // Lazy eager loading
        $review->load('user');
        $this->status = 200;
        $this->data=[
            "message"=> "Get Review Success",
            "data" => $review,
        ];
        return response($this->data, $this->status);
        
    }

    // NOTE: Oke ini gaada di use case tapi good la
    public function getReviewByUserID(int $userid){
        $review = Review::where(['user_id'=>$userid])->get();
        $this->status=200;
        $this->data=[
            "message"=> "Get Review Success",
            "data" => $review,
        ];
        return response($this->data,$this->status);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Review  $review
     * @return \Illuminate\Http\Response
     */
    public function destroy(int $id)
    {
        //
        try{
            $user = Auth::user();
            $review = Review::find($id);
            if ($review->user_id !=  $user->id) {
                $this->status = 403;
                return response($this->data, $this->status);
            }
            $review->delete();
            $this->status=200;
            $this->data=[
                'messege' => 'review deleted successfully',
                // 'data' => $review
            ];
            return response($this->data,$this->status);
        }catch(\Exception $e){
            $this->data=$e->getMessage();
            $this->status = 500;
            return response($this->data, $this->status);
        }
        
        
    }
}
