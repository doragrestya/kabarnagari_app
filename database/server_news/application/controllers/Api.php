<?php

      defined('BASEPATH') OR exit('No Script Direct');

      class Api extends CI_Controller{
      	function __construct(){
      		parent:: __construct();
      		date_default_timezone_set('Asia/Jakarta');
      		error_reporting(E_ALL);
      		ini_set('Display Error', 1);
      	}

            function getOlahragaa(){
                  $kategori = 'olahraga';
                  $this->db->where('category_news', $kategori);
                  $query = $this->db->get('tb_news');
                  //$query = $this->db->get('tb_news');
                  if($kategori != null || $ikategori != ""){
                        if($query -> num_rows() > 0){
                              $data['message'] = "Successfully Get Data News With Id";
                              $data['status'] = 200;
                              $data['olahraga'] = $query->result();
                        }else{
                              $data['message'] = "Failed Get Data News Olahraga";
                              $data['status'] = 400;
                        }
                  } else {
                         $q = $this->db->get('tb_news');
                         if($q -> num_rows() > 0){
                              $data['message'] = "Successfully Get Data News Without Id";
                              $data['status'] = 200;
                              $data['olahraga'] = $q->result();
                        }else{
                              $data['message'] = "Failed Get Data News Olahraga";
                              $data['status'] = 400;
                        }

                  }
                  echo json_encode($data);
            }

            function getOlahraga(){
                  $kategori = 'olahraga';
                  $this->db->where('category_news', $kategori);
                  $q = $this->db->get('tb_news');
                  if($q->num_rows() > 0){
                        $data['message'] = 'Success Get Data';
                        $data['status'] = 200;
                        $data['item'] = $q -> result();
                  } else {
                        $data['message'] = 'Failed Get Data';
                        $data['status'] = 404;
                  }
                  echo json_encode($data);
            }

            function getPendidikan(){
                  $kategori = 'pendidikan';
                  $this->db->where('category_news', $kategori);
                  $q = $this->db->get('tb_news');
                  if($q->num_rows() > 0){
                        $data['message'] = 'Success Get Data';
                        $data['status'] = 200;
                        $data['item'] = $q -> result();
                  } else {
                        $data['message'] = 'Failed Get Data';
                        $data['status'] = 404;
                  }
                  echo json_encode($data);
            }

            function getPolitik(){
                  $kategori = 'politik';
                  $this->db->where('category_news', $kategori);
                  $q = $this->db->get('tb_news');
                  if($q->num_rows() > 0){
                        $data['message'] = 'Success Get Data';
                        $data['status'] = 200;
                        $data['item'] = $q -> result();
                  } else {
                        $data['message'] = 'Failed Get Data';
                        $data['status'] = 404;
                  }
                  echo json_encode($data);
            }

            function deleteNews(){
                  $idNews = $this->input->post('idnews');
                  $this->db->where('id_news', $idNews);

                  $status = $this->db->delete('tb_news');
                  if ($status == true){
                        $data['message'] = "Successfully delete news";
                        $data['status'] = 200;
                  }else {
                        $data['message'] = "Failed delete news";
                        $data['status'] = 404;
                  }
                  echo json_encode($data);
            }


            function updateNews(){
                  $idNews = $this->input->post('idnews');
                  $title = $this->input->post('title');
                  $content = $this->input->post('content');
                  $descript = $this->input->post('description');

                  $config['upload_path'] = './image_news/';
                  $config['allowed_types'] = 'gif|jpg|png|jpeg';


                  $this->load->library('upload', $config);
                  $this->db->where('id_news', $idNews);


                  if(! $this->upload->do_upload('image')){
                        $save['title_news'] = $title;
                        $save['content_news'] = $content;
                        $save['description_news'] = $descript;
                        $save['date_news'] = date('Y-m-d H:i:s');
                        $query = $this->db->update('tb_news', $save);
                        $data1 = array(
                              'message' => "Successfully Upload News Without Image",
                              'status' => 200,
                        );
                  } else {

                        // Upload to folder
                        $data = array('upload_data' => $this->upload->data());  

                        // Upload to database
                        $save['title_news'] = $title;
                        $save['content_news'] = $content;
                        $save['description_news'] = $descript;
                        $save['date_news'] = date('Y-m-d H:i:s');
                        $save['image_news'] = $data['upload_data']['file_name'];
                        $query = $this->db->update('tb_news', $save);

                        // Ouput Request
                        $data1 = array(
                              'message' => "Successfully Upload News",
                              'status' => 200,
                              'data' => $data['upload_data']['file_name'],
                        );

                  }

                  echo json_encode($data1);
            }


            function updateImage(){
                  $idUser = $this->input->post('iduser');
                  $config['upload_path'] = './image_news/';
                  $config['allowed_types'] = 'gif|jpg|png|jpeg';

                  $this->db->where('id_user', $idUser);
                  $this->load->library('upload', $config);


                  if (! $this->upload->do_upload('image')) {
                        $error = array('error' => $this->upload->display_errors());
                        $data1 = array(
                              'message' => $error,
                              'status' => 404,
                        );
                  } else {
                        //upload to folder
                        $data = array('upload_data' => $this->upload->data());

                        //upload to database 
                        $save['photo_user'] = $data['upload_data']['file_name'];
                        $query = $this->db->update('tb_user', $save);

                        //output request
                        $data1 = array(
                              'message' => 'Successfully Update News',
                              'status' => 200,
                              'data' => $data['upload_data']['file_name'],
                        );
                  }

                  echo json_encode($data1);

            }

            function updateProfile(){
                  $idUser = $this->input->post('iduser');
                  $name = $this->input->post('name');
                  $email = $this->input->post('email');
                  $password = $this->input->post('password');
                  $this->db->where('id_user', $idUser);

                  if ($name == null || $name == "") {
                        $update['email_user'] = $email;
                        $update['password_user'] = md5($password);
                        $query = $this->db->update('tb_user', $update);
                        if ($query) {
                              $data['message'] = 'Successfully Without Name';
                              $status['status'] = 200;
                        } else {
                              $data['message'] = 'Failed Without Name';
                              $status['status'] = 404;
                        }
                  } else if ($email == null || $email == "") {
                        $update['fullname_user'] = $name;
                        $update['password_user'] = md5($password);
                        $query = $this->db->update('tb_user', $update);
                        if ($query) {
                              $data['message'] = 'Successfully Without Name';
                              $status['status'] = 200;
                        } else {
                              $data['message'] = 'Failed Without Name';
                              $status['status'] = 404;
                        }
                  } else if ($password == null || $password == "") {
                        $update['email_user'] = $email;
                        $update['fullname_user'] = $name;
                        $query = $this->db->update('tb_user', $update);
                        if ($query) {
                              $data['message'] = 'Successfully Without Name';
                              $status['status'] = 200;
                        } else {
                              $data['message'] = 'Failed Without Name';
                              $status['status'] = 404;
                        }
                  } else {
                        $update['email_user'] = $email;
                        $update['fullname_user'] = $name;
                        $update['password_user'] = md5($password);
                        $query = $this->db->update('tb_user', $update);
                        if ($query) {
                              $data['message'] = 'Successfully Without Name';
                              $status['status'] = 200;
                        } else {
                              $data['message'] = 'Failed Without Name';
                              $status['status'] = 404;
                        }
                  }
                  echo json_encode($data);
            }

      	function addNews(){
      		$title = $this->input->post('title');
      		$content = $this->input->post('content');
      		$descript = $this->input->post('description');
      		$config['upload_path'] = './image_news/';
      		$config['allowed_types'] = 'gif|jpg|png|jpeg';

      		$this->load->library('upload', $config);

      		if (! $this->upload->do_upload('image')) {
      			$error = array('error' => $this->upload->display_errors());
      			$data1 = array(
      				'message' => $error,
      				'status' => 404,
      			);
      		} else {
      			//upload to folder
      			$data = array('upload_data' => $this->upload->data());

      			//upload to database 
      			$save['title_news'] = $title;
      			$save['content_news'] = $content;
      			$save['description_news'] = $descript;
      			$save['date_news'] = date('Y-m-d');
      			$save['image_news'] = $data['upload_data']['file_name'];
      			$query = $this->db->insert('tb_news', $save);

      			//output request
      			$data1 = array(
      				'message' => 'Successfully Upload News',
      				'status' => 200,
      				'data' => $data['upload_data']['file_name'],
      			);
      		}

      		echo json_encode($data1);
      	}

      	function getNews(){
                  $idUser = $this->input->post('iduser');
                  $this->db->order_by('date_news', 'DESC');
                  $this->db->where('id_user', $idUser);
                  $query = $this->db->get('tb_news');
                  //$query = $this->db->get('tb_news');
                  if($idUser != null || $idUser != ""){
                        if($query -> num_rows() > 0){
                              $data['message'] = "Successfully Get Data News With Id";
                              $data['status'] = 200;
                              $data['article'] = $query->result();
                        }else{
                              $data['message'] = "Failed Get Data News";
                              $data['status'] = 400;
                        }
                  } else {
                         $q = $this->db->get('tb_news');
                         if($q -> num_rows() > 0){
                              $data['message'] = "Successfully Get Data News Without Id";
                              $data['status'] = 200;
                              $data['article'] = $q->result();
                        }else{
                              $data['message'] = "Failed Get Data News";
                              $data['status'] = 400;
                        }

                  }
                  echo json_encode($data);
            }

            function getNews1(){
                  // $idUser = $this->input->post('iduser');
                  // $this->db->order_by('date_news', 'DESC');
                  // $this->db->where('id_user', $idUser);
                  // $query = $this->db->get('tb_news');
                  //$query = $this->db->get('tb_news');
                  // if($idUser != null || $idUser != ""){
                  //       if($query -> num_rows() > 0){
                  //             $data['message'] = "Successfully Get Data News With Id";
                  //             $data['status'] = 200;
                  //             $data['article'] = $query->result();
                  //       }else{
                  //             $data['message'] = "Failed Get Data News";
                  //             $data['status'] = 400;
                  //       }
                  // } else {
                         $q = $this->db->get('tb_news');
                         if($q -> num_rows() > 0){
                              $data['message'] = "Successfully Get Data News Without Id";
                              $data['status'] = 200;
                              $data['article'] = $q->result();
                        }else{
                              $data['message'] = "Failed Get Data News";
                              $data['status'] = 400;
                        }
                  echo json_encode($data);
            }

            function getNewsbyid(){
                  $kateg = $this->input->post('iduser');
                  $this->db->order_by('date_news', 'DESC');
                  $this->db->where('id_user', $idUser);
                  $query = $this->db->get('tb_news');
                  //$query = $this->db->get('tb_news');
                  if($idUser != null || $idUser != ""){
                        if($query -> num_rows() > 0){
                              $data['message'] = "Successfully Get Data News With Id";
                              $data['status'] = 200;
                              $data['article'] = $query->result();
                        }else{
                              $data['message'] = "Failed Get Data News";
                              $data['status'] = 400;
                        }
                  }
                  echo json_encode($data);
            }
            
      	function registerUser(){
      		$namefull = $this->input->post('name');
      		$email = $this->input->post('email');
      		$password = $this->input->post('password');

      		$this->db->where('email_user', $email);
      		$q = $this->db->get('tb_user');

      		if($q -> num_rows() > 0){
      			$data['status'] = 404;
      			$data['message'] = "Email telah terdaftar";
      		} else {
      			$save['fullname_user'] = $namefull;
      			$save['email_user'] = $email;
      			$save['password_user'] = md5($password);

      			$querySaved = $this->db->insert('tb_user', $save);

      			if ($querySaved) {
      				$data['status'] = 200;
      				$data['message'] = 'Successfully Register';
      			} else {
      				$data['status'] = 404;
      				$data['message'] = 'Failed Register';
      			}
      		}
      		echo json_encode($data);
      	}
            
      	function loginUser(){
      		$email = $this->input->post('email');
      		$password = $this->input->post('password');

      		$this->db->where('email_user', $email);
      		$this->db->where('password_user', md5($password));

      		$q = $this->db->get('tb_user');

      		if($q -> num_rows() > 0){
      			$data['status'] = 200;
      			$data['message'] = 'Successfully Login User';
      			$data['user'] = $q->result();
      		} else {
      			$data['status'] = 404;
      			$data['message'] = 'Failed Login User';
      		}
      		echo json_encode($data);
      	}

      }
?>