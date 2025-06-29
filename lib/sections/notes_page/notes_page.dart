import 'package:economics_app/app/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../app/enums/syllabus_enum.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Study notes'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: notes.length,
              (context, index) => ExpansionTile(
                title: Text(
                  notes[index].unit.entries.first.value,
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * kPageIndentHorizontal,
                      vertical: size.height * kPageIndentVertical,
                    ),
                    child: HtmlWidget(notes[index].note),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final notes = [
  Note(
    note: perfectCompetitionNotes,
    syllabus: Syllabus.ib,
    unit: {'2.11': 'Perfect Competition (HL)'},
  ),
  Note(
    note: monopolyNotes,
    syllabus: Syllabus.ib,
    unit: {'2.11': 'Monopoly (HL)'},
  )
];

class Note {
  final String note;
  final Syllabus syllabus;
  final Map<String, String> unit;

  Note({required this.note, required this.syllabus, required this.unit});
}

const perfectCompetitionNotes = """
<h2>Perfect Competition</h2>

<ul>
  <li>Many buyers and sellers</li>
  <li>Homogeneous product</li>
  <li>No barriers to entry and exit</li>
  <li>Price taker</li>
  <li>Perfect information</li>
  <li>Perfect factor mobility (e.g. labor & capital)</li>
  <li>Allocatively efficient (produce where P=MC)</li>
  <li>Firms are profit maximizers (produce where MR = MC)</li>
</ul>

<h3>Short Run</h3>
<ul>
  <li>Firms may earn abnormal profits (TR &gt; TC) or make losses (TR &lt; TC).</li> 
  <li>Shutdown point: If AR < AVC firms are better off shutting down.</li>
</ul>

<h3>Long Run</h3>
<ul>
  <li>Firms can only make normal profit (zero economic profit) due to free entry & exit in the industry</li>
  <li>Allocatively efficiency: P = MC</li>
  <li>Productively efficiency: MC = AC</li>
</ul>

<h3>Drawbacks</h3>
<ul>
  <li>Limited consumer choice</li>
  <li>Low profits reduce incentives for innovation (not dynamically efficient)</li>
</ul>

<h3>Real-World Examples</h3>
<ul>
  <li>Currency exchange</li>
  <li>Fresh fruit markets</li>
  <li>Commodities (e.g. wheat, copper)</li>
</ul>
""";

const monopolyNotes = """
<h2>Monopoly</h2>

<h3>Characteristics of a Monopoly</h3>
<ul>
  <li>Single firm in the industry</li>
  <li>Produces a unique product with no close substitutes</li>
  <li>High barriers to entry</li>
  <li>Price-setter</li>
</ul>

<p><strong>Not allocatively efficient:</strong> P &gt; MC (market failure)</p>
<p><strong>Not productively efficient:</strong> MC ≠ AC</p>
<p>A monopoly has market power, represented by a downward-sloping demand curve.</p>
<p>A monopoly will always charge on the elastic portion of the demand curve where P &gt; MC.</p>
<p>A monopoly can earn economic profits in the long-run if it maintains its barriers to entry.</p>

<h3>Barriers to Entry</h3>
<ul>
  <li>Economies of scale</li>
  <li>Branding</li>
  <li>Legal protection</li>
  <li>Control of essential resources</li>
  <li>Aggressive tactics</li>
</ul>

<p>A monopoly will charge where MC = MR. Alternatively, it might aim to maximize sales revenue where MR = 0.</p>

<h3>Natural Monopoly</h3>
<p>A natural monopoly exists when one firm can supply the entire market at lower long-run average costs than multiple firms due to significant economies of scale.</p>
<p><strong>Examples:</strong> railway and telecommunication networks</p>
<p>Some natural monopolies may be loss-making; governments may subsidize them due to their wider social benefits (e.g. utilities, railways).</p>

<h3>Evaluation</h3>

<h4>Advantages</h4>
<ul>
  <li>Natural monopolies are often the only viable option due to high fixed costs</li>
  <li>Lower prices if regulated, due to lower average costs</li>
  <li>Easier to regulate in industries important to national security</li>
  <li>Use of supernormal profits to invest in research and development</li>
</ul>

<h4>Disadvantages</h4>
<ul>
  <li>Allocatively inefficient: P &gt; MC</li>
  <li>Not productively efficient: MC ≠ AC</li>
  <li>Restricts output to maximize profit, reducing consumer and social welfare</li>
  <li>Worsens income distribution – higher prices affect poorer consumers more</li>
  <li>May use aggressive/anticompetitive tactics to block competition</li>
</ul>

<h3>Solutions to Monopoly</h3>
<p>Government interventions include:</p>
<ul>
  <li><strong>Nationalization</strong> – but may lead to inefficiency and high opportunity costs</li>
  <li><strong>Regulations</strong> – break up monopoly or restrict its trading behavior</li>
  <li><strong>Price controls:</strong>
    <ul>
      <li><strong>Average cost pricing (P = AC):</strong> Monopoly earns normal profits. However, it may reduce incentives to minimize costs.</li>
      <li><strong>Marginal cost pricing (P = MC):</strong> Also called “socially optimal pricing”. It often leads to losses, requiring government subsidies.</li>
    </ul>
  </li>
</ul>
""";
