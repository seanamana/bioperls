using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MeltTempLookup.IDTService;

namespace MeltTempLookup
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string seq = textBox1.Text;
            OligoAnalyzerSoapClient client = new OligoAnalyzerSoapClient("OligoAnalyzerSoap");

            AnalyzerResult result = client.Analyze(seq, "DNA", 0.2, 50, 3, 0.8);
            label1.Text = "" + result.MeltTemp;
        }
    }
}
