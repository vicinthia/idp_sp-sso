import 'package:flutter/material.dart';

class fiturUmumKop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  child: Image.asset('assets/kop.jpg', fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 20),
              // Image.asset('assets/zakat_maal.png'),
              Text(
                "Koperasi Kepegawaian",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Koperasi Pegawai Republik Indonesia (KPRI) UM mengembangkan unit usaha, yang meliputi unit usaha simpan pinjam, unit usaha pertokoan/swalayan, pembayaran rekening listrik, telepon, dan air secara kolektif",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 16),
              Divider(),
              Text(
                "Koperasi untuk kepegawaian di kampus biasanya dirancang khusus untuk mendukung kebutuhan dosen, staf administrasi, dan pegawai lainnya. Fokus utama koperasi ini adalah meningkatkan kesejahteraan anggota melalui berbagai program ekonomi dan keuangan. Berikut adalah informasi umum mengenai koperasi kepegawaian:",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(16),
                color: Colors.green.shade50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pengelolaan Koperasi",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Koperasi kepegawaian dikelola oleh pengurus yang dipilih dari dan oleh anggota. Pengurus bertanggung jawab untuk menjalankan operasi koperasi, memastikan transparansi keuangan, dan memberikan laporan rutin kepada anggota.',
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Dengan berpartisipasi dalam koperasi, pegawai kampus tidak hanya memperoleh manfaat ekonomi tetapi juga berkontribusi dalam membangun solidaritas di lingkungan kerja.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // ListTile(
              //   leading: Icon(Icons.calculate),
              //   title: Text('Kalkulator Zakat Fitrah'),
              //   trailing: Icon(Icons.arrow_forward_ios),
              //   onTap: () {
              //     // Navigate to the calculator page
              //     m_Harga.connectToAPI().then((value) {
              //       m_harga = value;
              //       Navigator.of(context).push(MaterialPageRoute(
              //           builder: (context) => ZakatCalculator(
              //               selectedZakatType: "Zakat Fitrah",
              //               nominalFitrah: int.tryParse(m_harga.fitrah) ?? 0)));
              //     });
              //   },
              // ),

              SizedBox(height: 16),
              Divider(),
              SizedBox(height: 16),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => transaksiFitrah()));
              //   },
              //   style: ElevatedButton.styleFrom(
              //     primary: DesignCourseAppTheme.green, // background
              //     minimumSize: Size(double.infinity, 50), // set button size
              //   ),
              //   child: Text("Bayar Zakat Sekarang"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
