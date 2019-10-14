package com.hhwy.fm_baidu_map.location;

import com.baidu.location.BDAbstractLocationListener;
import com.baidu.location.BDLocation;
import com.baidu.location.BDLocationListener;
import com.baidu.location.LocationClient;
import com.baidu.location.LocationClientOption;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * 百度监听类
 */
@SuppressWarnings("unchecked")
public class FmBaiduLocationImpClientBaidu extends FmBaiduLocationImpClient {
    // 控制监听
    LocationClient _client;
    // 监听消息
//    BDLocationListener _listener;
    MyLocationListener _listener;
    // 构造函数
    public FmBaiduLocationImpClientBaidu(String name, PluginRegistry.Registrar registrar, JSONObject options) {
        super(name, registrar);
        _client = new LocationClient(registrar.activity());
        // 设置
        LocationClientOption locationClientOption = new LocationClientOption();
        locationClientOption.setCoorType("bd09ll");
        locationClientOption.setOpenGps(true);
        locationClientOption.setLocationMode(LocationClientOption.LocationMode.Hight_Accuracy);
        locationClientOption.setScanSpan(1000);
//        locationClientOption.disableCache(true);
        locationClientOption.setIsNeedAltitude(true);
        locationClientOption.setNeedDeviceDirect(true);
        _client.setLocOption(locationClientOption);

//        _listener = new BDLocationListener() {
//            @Override
//            public void onReceiveLocation(BDLocation bdLocation) {
//                HashMap<String, Object> jsonObject = new HashMap();
//                jsonObject.put("coordType", "Baidu");
//                jsonObject.put("time", System.currentTimeMillis());
//                jsonObject.put("speed", bdLocation.getSpeed());
//                jsonObject.put("altitude", bdLocation.getAltitude());
//                jsonObject.put("latitude", bdLocation.getLatitude());
//                jsonObject.put("longitude", bdLocation.getLongitude());
//                jsonObject.put("bearing", bdLocation.getDirection());
//                jsonObject.put("locType", bdLocation.getLocType());
//                jsonObject.put("radius", bdLocation.getRadius());
//                _ftb.invokeMethod("onLocation", jsonObject);
//            }
//        };
//        _client.registerLocationListener(_listener);

        _listener = new MyLocationListener();
        _client.registerLocationListener(_listener);
        //此时onInited事件还没注册，因此无法调用成功。
//        _ftb.invokeMethod("onInited", null);
    }

    /**
     * 实现定位回调
     */
    public class MyLocationListener extends BDAbstractLocationListener {
        @Override
        public void onReceiveLocation(BDLocation location){
            //此处的BDLocation为定位结果信息类，通过它的各种get方法可获取定位相关的全部结果
            //以下只列举部分获取经纬度相关（常用）的结果信息
            //更多结果信息获取说明，请参照类参考中BDLocation类中的说明

            //获取纬度信息
//            double latitude = location.getLatitude();
//            //获取经度信息
//            double longitude = location.getLongitude();
//            //获取定位精度，默认值为0.0f
//            float radius = location.getRadius();
//            //获取经纬度坐标类型，以LocationClientOption中设置过的坐标类型为准
//            String coorType = location.getCoorType();
//            //获取定位类型、定位错误返回码，具体信息可参照类参考中BDLocation类中的说明
//            int errorCode = location.getLocType();
//            BDLocation
            HashMap<String, Object> jsonObject = new HashMap();
            jsonObject.put("coordType", location.getCoorType());
            jsonObject.put("time", System.currentTimeMillis());
            jsonObject.put("speed", location.getSpeed());
            jsonObject.put("altitude", location.getAltitude());
            jsonObject.put("latitude", location.getLatitude());
            jsonObject.put("longitude", location.getLongitude());
            jsonObject.put("radius", location.getRadius());
            jsonObject.put("bearing", location.getDirection());
            jsonObject.put("locType", location.getLocType());
            jsonObject.put("locTypeDesc", location.getLocTypeDescription());

            _ftb.invokeMethod("onLocation", jsonObject);

        }
    }

    @Override
    public void start() {
        if (_client.isStarted()) {
            return;
        }
        _client.start();

    }

    @Override
    public boolean isStarted() {
        return _client.isStarted();
    }

    @Override
    public void stop() {
        _client.stop();
    }

    @Override
    public void dispose() {
        _client.unRegisterLocationListener(_listener);
        _listener = null;
        _client.stop();
        _client = null;
        super.dispose();
    }
}
