package chart;

import com.dukascopy.api.*;
import com.dukascopy.api.IEngine.OrderCommand;
import com.dukascopy.api.drawings.ICustomWidgetChartObject;
import com.dukascopy.api.feed.IFeedDescriptor;
import com.dukascopy.api.feed.util.*;
import java.awt.Color;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.lang.instrument.Instrumentation;
import java.util.*;
import java.util.Iterator;
import java.util.concurrent.Callable;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class WidgetTest implements IStrategy {
    private IContext _context;
    private Set<Instrument> _all_instrument;
    private IChart _cur_chart;

    @Override
    public void onStart(final IContext context) throws JFException {
        this._context = context;
        this._all_instrument = context.getSubscribedInstruments();
        final Instrument instrument = Instrument.EURUSD;
        //final IChart chart = context.getChart(instrument);
        this._cur_chart = context.getLastActiveChart();
        if (this._cur_chart == null) {
            context.getConsole().getErr().println("No chart opened!");
            context.stop();
        }
        else {
            //Instrument i = chart.getInstrument();
            //chart.setInstrument(Instrument.EURUSD);
           //context.getConsole().getOut().println(i.toString());

           //IFeedDescriptor f = 
        //new TimePeriodAggregationFeedDescriptor(Instrument.EURUSD, Period.DAILY, OfferSide.BID);
        //chart.setFeedDescriptor(f);//设置新图表  打开图表
    ////IChart c = context.openChart(f); 
            //for (Instrument ii : context.getSubscribedInstruments()) {

           ////context.getConsole().getOut().println(ii.toString());
            //}
            //return;

        }



        ICustomWidgetChartObject obj = this._cur_chart.getChartObjectFactory().createChartWidget();
        //obj.setText("Price marker adder");
        
        //obj.setFillOpacity(0.1f); //use 0f for transparent chart widget
        //obj.setColor(Color.GREEN.darker());
        
        JPanel panel = obj.getContentPanel();
        panel.setLayout(new BoxLayout(panel, BoxLayout.PAGE_AXIS));
        final JLabel label = new JLabel(this._cur_chart.getAll().size() + " chart objects on chart");
        label.setAlignmentX(Component.CENTER_ALIGNMENT);
        JButton b0 = new JButton("打开新图表");
        b0.setAlignmentX(Component.CENTER_ALIGNMENT);
        b0.addActionListener(new ActionListener(){
            @Override
            public void actionPerformed(ActionEvent e) {
            IFeedDescriptor f = findNextFeed();
            openNewChart(f);
            }});

        JButton b1 = new JButton("打开图表");
        b1.setAlignmentX(Component.CENTER_ALIGNMENT);
        b1.addActionListener(new ActionListener(){
            @Override
            public void actionPerformed(ActionEvent e) {
            IFeedDescriptor f = findNextFeed();
            openChart(f);
            }});
        
        panel.add(Box.createRigidArea(new Dimension(0,10)));
        panel.add(label);
        panel.add(Box.createRigidArea(new Dimension(0,5)));
        panel.add(b0);
        panel.add(Box.createRigidArea(new Dimension(0,5)));
        panel.add(b1);
        panel.setSize(new Dimension(250, 100));
        panel.setMinimumSize(new Dimension(250, 100));
        panel.setMaximumSize(new Dimension(350, 120));
        this._cur_chart.add(obj);

    }

    public void onTick(Instrument instrument, ITick tick) throws JFException {}
    public void onMessage(IMessage message) throws JFException {}
    public void onAccount(IAccount account) throws JFException {}
    public void onStop() throws JFException { }
    public void onBar(Instrument instrument, Period period, IBar askBar, IBar bidBar) throws JFException {}

    public void openChart(IFeedDescriptor f) {
        this._cur_chart.setFeedDescriptor(f);
    }
    public void openNewChart(IFeedDescriptor f) {
        this._context.openChart(f); 
    }
    public IFeedDescriptor findNextFeed() {
        Instrument curI = this._context.getLastActiveChart().getInstrument();
        Iterator<Instrument> it = this._all_instrument.iterator();
        while(it.hasNext()) {
            if(it.next().toString() == curI.toString()) {
                this._context.getConsole().getOut().println(curI.toString());
                break;
            }
        }
        if(it.hasNext()) {
            return (new TimePeriodAggregationFeedDescriptor(Instrument.valueOf(it.next().toString()), Period.DAILY, OfferSide.BID));
        }
        return null;
    }
}
