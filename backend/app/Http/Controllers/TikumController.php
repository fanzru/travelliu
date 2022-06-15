<?php

namespace App\Http\Controllers;

use App\Models\Tikum;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class TikumController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        try {
            $tikum = Tikum::with('user:id,name,created_at,updated_at')->where('waktu_kumpul', '>', DB::raw('NOW()'))->orderByDesc('waktu_kumpul')->get();
            return response($tikum, 200);
        } catch (\Exception $e) {
            return response("Internal Server Error", 500);
        }
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
                'tempat_tujuan' => ['required'],
                'tempat_kumpul' => ['required'],
                'waktu_kumpul' => ['required'],
                'link_group' => [],
                'deskripsi' => []
            ]);
            $user = Auth::user();
            if (strlen(trim($request->deskripsi)) != 0) {
                if (predictTextIsSpam($request->deskripsi)) {
                    return response("Deskripsi terdeteksi spam", 400);
                }
            }
            $tikum = $user->tikum()->create($validated);
            return response($tikum, 200);
        } catch (\Illuminate\Validation\ValidationException $e) {
            return response("Request tidak valid", 400);
        } catch (\Exception $e) {
            return response("Internal Server Error", 500);
        }
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
            $komentar = Tikum::findOrFail($id);
            if ($komentar->user_id != $user->id) {
                return response("Tikum tidak valid", 403);
            }
            $komentar->delete();
            return response("Delete Success", 200);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response("Tikum tidak ditemukan", 400);
        } catch (\Exception $e) {
            return response("Internal Server Error", 500);
        }
    }
}
