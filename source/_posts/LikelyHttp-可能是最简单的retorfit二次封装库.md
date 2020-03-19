---
title: LikelyHttp -- 可能是最简单的retorfit二次封装库
date: 2020-03-19 16:53:26
tags:
---

# LikelyHttp -- 可能是最简单的retorfit二次封装库

> retorfit + okhttp可能现阶段最常见的android网络请求库了,网上针对retorfit和okhttp二次封装的库层出不穷, 其中有很多很优秀功能也很强大的库,但功能强大和内容丰富很有可能带来了更多的耦合从而导致这些第三方的库在使用的时候不尽如人意,很多的时候我们的使用第三方的库的目的是使得我们的使用更加的简洁和简单. 二是网络库是一个使用频率十分高的库,为此为自己封装一个自己使用更加顺手的库,为此才有了个做了减法的LikeluHttp.

  <!-- more -->

## 如何使用

```java
        //定义OkHttp相关, 注册拦截器相关的
        OkHttpClient mOkHttpClient = new OkHttpClient.Builder()
                .addInterceptor(LogInterceptor())
                .build();
        //定义Retrofit相关
        Retrofit mRetrofit = new Retrofit.Builder()
                .baseUrl(BasUrl)
                //添加gson转换器
                .addConverterFactory(GsonConverterFactory.create())
                //添加rxjava转换器
                .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
                .client(mOkHttpClient)
                .build();
        //获取接口定义接口
        BaseNetApi baseNetApi = mRetrofit.create(BaseNetApi.class);

        //配置LikelyHttp相关功能信息
        //暂时支持配置的功能比较少
        LikelyHttp.getInstance()
        //增加请求统一处理
        .setUniteDeal(new BaseObserverInterface() {
            //请求开始
            @Override
            public void onRequestStart() {
                Toast.makeText(MainActivity.this, "onRequestStart", Toast.LENGTH_SHORT).show();
            }

            //请求完成, 包含成功和失败
            @Override
            public void onRequestEnd() {
                Toast.makeText(MainActivity.this, "onRequestEnd", Toast.LENGTH_SHORT).show();
            }

            //请求状态码异常
            @Override
            public void onCodeError(int errorCode) {
                Toast.makeText(MainActivity.this, "onCodeError: " + errorCode, Toast.LENGTH_SHORT).show();
            }
        })
        //设置请求成功状态(默认为200)
        .setUniteDeal(200)
        ;

        //使用
        LikelyHttp.getInstance().start(baseNetApi.getHome(), new BaseObserver<String>(){
            @Override
            protected void onSuccees(BaseEntity<String> t) throws Exception {
                Toast.makeText(MainActivity.this, "onSuccees", Toast.LENGTH_SHORT).show();
                //获取内容
                t.getData()
            }

            @Override
            protected void onFailure(Throwable e, boolean isNetWorkError) throws Exception {
                Toast.makeText(MainActivity.this, "onFailure", Toast.LENGTH_SHORT).show();
            }
        });

        //不使用请求统一处理
        //默认为使用情况统一处理
        LikelyHttp.getInstance().start(baseNetApi.getHome(), new BaseObserver<String>(false){
                  ...
        });

        //返回回调放入非主线程中使用
        //默认回调放入主线程
        LikelyHttp.getInstance().start(baseNetApi.getHome(), new BaseObserver<String>(){
                  ...
        }, true);

```

其中BaseNetApi为平时使用的接口类,用于定义网络请求

```java
public interface BaseNetApi {
    @GET("clwater")
    Observable<BaseEntity<String>> getHome();
}
```


## 使用详情
1. 简单get请求

模拟最简单的get success请求

![简单get请求](https://user-gold-cdn.xitu.io/2019/12/6/16ed6cadc8c853dd?w=1024&h=2163&f=gif&s=1079003)

2. 简单get请求(失败)

模拟最简单的get fail请求

![简单getfail请求](https://user-gold-cdn.xitu.io/2019/12/6/16ed6cadc59da66f?w=1024&h=2163&f=gif&s=932539)

3. 服务器返回状态码错误的情况(统一处理)

模拟服务器返回状态码错误的情况

![简单codeerror请求](https://user-gold-cdn.xitu.io/2019/12/6/16ed6cadc8ca4f3a?w=1024&h=2163&f=gif&s=330080)


4. 简单的post请求

模拟简单的post请求

![简单post请求](https://user-gold-cdn.xitu.io/2019/12/6/16ed6cadd237505e?w=1024&h=2163&f=gif&s=935163)

4. 异步线程回调模拟

模拟异步线程回调模拟

![io](https://user-gold-cdn.xitu.io/2019/12/6/16ed6cadca174625?w=1024&h=2163&f=gif&s=1181851)



## 如何封装
1. BaseEntity 请求默认返回结构
  BaseEntity暂时不支持自定义结构,后续会增加此部分的自定义情况

```java
请求默认返回格式
// {
//     "status": 200,
//     "message": "success",
//     "data": {}
// }

public class BaseEntity<T> {
    public static int SUCCESS_CODE = 200;
    private int status;
    private String msg;
    private T data;


    public boolean isSuccess(){
        return getCode() == SUCCESS_CODE;
    }
    public int getCode() {
        return status;
    }

    public void setCode(int code) {
        this.status = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

}

2. BaseObserver请求回调处理,包含每个请求的成功与失败以及统一的情况处理

public abstract class BaseObserver<T> implements Observer<BaseEntity<T>> {

    /*
     * 是否经过统一处理, 默认均使用
     */
    private boolean userUniteDeal = true;

    private static BaseObserverInterface baseObserverInterface;

    public static void setBaseObserverInterface(BaseObserverInterface baseObserverInterface) {
        BaseObserver.baseObserverInterface = baseObserverInterface;
    }

    public BaseObserver() {

    }

    public BaseObserver(boolean useLoading) {
        this.userUniteDeal = useLoading;
    }

    @Override
    public void onSubscribe(Disposable d) {
        onRequestStart();
    }

    @Override
    public void onNext(BaseEntity<T> tBaseEntity) {
        onRequestEnd();
        if (tBaseEntity.isSuccess()) {
            try {
                onSuccees(tBaseEntity);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            try {
                onCodeError(tBaseEntity);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void onError(Throwable e) {
        onRequestEnd();
        try {
            if (e instanceof ConnectException
                    || e instanceof TimeoutException
                    || e instanceof NetworkErrorException
                    || e instanceof UnknownHostException) {
                onFailure(e, true);
            } else {
                onFailure(e, false);
            }
        } catch (Exception e1) {
            e1.printStackTrace();
        }
    }

    @Override
    public void onComplete() {
    }

    /**
     * @param t
     * @throws Exception
     * 网络请求成功, 状态码错误
     */
    protected void onCodeError(BaseEntity<T> t) throws Exception {
        baseObserverInterface.onCodeError(t.getCode());
    }


    /**
     * @param t
     * @throws Exception
     * 请求成功(网络及状态码code)
     */
    protected abstract void onSuccees(BaseEntity<T> t) throws Exception;

    /**
     * @param e
     * @param isNetWorkError 是否是网络错误
     * @throws Exception
     * 网络请求失败
     */
    protected abstract void onFailure(Throwable e, boolean isNetWorkError) throws Exception;


    /**
     * 网络请求开始
     */
    protected void onRequestStart() {
        if (userUniteDeal) {
            baseObserverInterface.onRequestStart();
        }
    }

    /**
     * 网络请求完成(包括成功及失败)
     */
    protected void onRequestEnd() {
        if (userUniteDeal) {
            baseObserverInterface.onRequestEnd();
        }
    }


}


```


## 代码
相关代码可以访问我的[GitHub](https://github.com/clwater/LikelyHttp.git)