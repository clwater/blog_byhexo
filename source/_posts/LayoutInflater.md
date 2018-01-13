---
title: Android View 相关源码分析之二 继LayoutInflater来说
date: 2017-02-03 17:39:24
tags: ["android" , "view" , "源码"]
categories: "android"
---
### LayoutInflater源码分析
1. 与setContentView相关

  在PhoneWindow的generateLayout中调用了     
  ```java
    View in = mLayoutInflater.inflate(layoutResource, null);
  ```

2. LayoutInflater中获取实例化方法
  ```java
    /**
     * Obtains the LayoutInflater from the given context.
     */
    public static LayoutInflater from(Context context) {
        LayoutInflater LayoutInflater =
                (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        if (LayoutInflater == null) {
            throw new AssertionError("LayoutInflater not found.");
        }
        return LayoutInflater;
    }
  ```
  <!-- more -->

3. inflate方法相关
  ```java
    public View inflate(@LayoutRes int resource, @Nullable ViewGroup root) {
        return inflate(resource, root, root != null);
    }

    public View inflate(XmlPullParser parser, @Nullable ViewGroup root) {
      return inflate(parser, root, root != null);
    }
  ```
  ```java
    public View inflate(@LayoutRes int resource, @Nullable ViewGroup root, boolean attachToRoot) {
        final Resources res = getContext().getResources();
        if (DEBUG) {
            Log.d(TAG, "INFLATING from resource: \"" + res.getResourceName(resource) + "\" ("
                    + Integer.toHexString(resource) + ")");
        }

        final XmlResourceParser parser = res.getLayout(resource);
        try {
            return inflate(parser, root, attachToRoot);
        } finally {
            parser.close();
        }
    }
  ```
  最后发现都需要调用

  ```java
  public View inflate(XmlPullParser parser, @Nullable ViewGroup root, boolean attachToRoot) {
          synchronized (mConstructorArgs) {
              Trace.traceBegin(Trace.TRACE_TAG_VIEW, "inflate");

              final Context inflaterContext = mContext;
              final AttributeSet attrs = Xml.asAttributeSet(parser);
              Context lastContext = (Context) mConstructorArgs[0];
              mConstructorArgs[0] = inflaterContext;
              //定义返回值 初始化传入形参 root
              View result = root;

              try {
                  // 找到根节点
                  int type;
                  while ((type = parser.next()) != XmlPullParser.START_TAG &&
                          type != XmlPullParser.END_DOCUMENT) {
                  }

                  //验证type是否为Start_Tag  保证xml文件正确
                  if (type != XmlPullParser.START_TAG) {
                      throw new InflateException(parser.getPositionDescription()
                              + ": No start tag found!");
                  }

                  //type为 root node
                  final String name = parser.getName();

                  if (DEBUG) {
                      System.out.println("**************************");
                      System.out.println("Creating root view: "
                              + name);
                      System.out.println("**************************");
                  }

                  if (TAG_MERGE.equals(name)) {
                      //处理 merge相关
                      //root需要非空 且attachToRoot为空
                      if (root == null || !attachToRoot) {
                          throw new InflateException("<merge /> can be used only with a valid "
                                  + "ViewGroup root and attachToRoot=true");
                      }
                      //递归inflate 方法调用
                      rInflate(parser, root, inflaterContext, attrs, false);
                  } else {
                      //根据tag节点创建view对象
                      final View temp = createViewFromTag(root, name, inflaterContext, attrs);

                      ViewGroup.LayoutParams params = null;

                      if (root != null) {
                          if (DEBUG) {
                              System.out.println("Creating params from root: " +
                                      root);
                          }
                          //根据root生成LayoutParams
                          params = root.generateLayoutParams(attrs);
                          if (!attachToRoot) {
                              //如果attachToRoot为flase 则调用setLayoutParams
                              temp.setLayoutParams(params);
                          }
                      }

                      if (DEBUG) {
                          System.out.println("-----> start inflating children");
                      }
                      //递归inflate剩下的children
                      rInflateChildren(parser, temp, attrs, true);

                      if (DEBUG) {
                          System.out.println("-----> done inflating children");
                      }

                      // We are supposed to attach all the views we found (int temp)
                      // to root. Do that now.
                      if (root != null && attachToRoot) {
                          //root非空且attachToRoot=true则将xml文件的root view加到形参提供的root里
                          root.addView(temp, params);
                      }

                      // Decide whether to return the root that was passed in or the
                      // top view found in xml.
                      if (root == null || !attachToRoot) {
                          //返回xml里解析的root view
                          result = temp;
                      }
                  }

              } catch (XmlPullParserException e) {
                  InflateException ex = new InflateException(e.getMessage());
                  ex.initCause(e);
                  throw ex;
              } catch (Exception e) {
                  InflateException ex = new InflateException(
                          parser.getPositionDescription()
                                  + ": " + e.getMessage());
                  ex.initCause(e);
                  throw ex;
              } finally {
                  // Don't retain static reference on context.
                  mConstructorArgs[0] = lastContext;
                  mConstructorArgs[1] = null;
              }

              Trace.traceEnd(Trace.TRACE_TAG_VIEW);
              //返回参数root或xml文件里的root view
              return result;
          }
      }

  ```
  相关inflate参数的结果
  ![inflate参数.png](http://ooymoxvz4.bkt.clouddn.com/18-1-13/22700304.jpg)

4. 相关方法解析
  在Inflate中多次被调用的rInflate

  ```java
     void rInflate(XmlPullParser parser, View parent, Context context,
             AttributeSet attrs, boolean finishInflate) throws XmlPullParserException, IOException {

         final int depth = parser.getDepth();
         int type;
         //XmlPullParser解析器的标准解析模式
         while (((type = parser.next()) != XmlPullParser.END_TAG ||
                 parser.getDepth() > depth) && type != XmlPullParser.END_DOCUMENT) {
             //找到start_tag节点
             if (type != XmlPullParser.START_TAG) {
                 continue;
             }
             //获取Name标记
             final String name = parser.getName();

             //private static final String TAG_REQUEST_FOCUS = "requestFocus";
             //处理requestFocus
             if (TAG_REQUEST_FOCUS.equals(name)) {
                 parseRequestFocus(parser, parent);
             // private static final String TAG_TAG = "tag";
             //处理tag
             } else if (TAG_TAG.equals(name)) {
                 parseViewTag(parser, parent, attrs);
             //private static final String TAG_INCLUDE = "include";
             //处理include
             } else if (TAG_INCLUDE.equals(name)) {
                 //如果是根节点则抛出异常
                 if (parser.getDepth() == 0) {
                     throw new InflateException("<include /> cannot be the root element");
                 }
                 parseInclude(parser, context, parent, attrs);
             //private static final String TAG_MERGE = "merge";
             //处理merge merge需要是xml中的根节点
             } else if (TAG_MERGE.equals(name)) {
                 throw new InflateException("<merge /> must be the root element");
             } else {
                 final View view = createViewFromTag(parent, name, context, attrs);
                 final ViewGroup viewGroup = (ViewGroup) parent;
                 final ViewGroup.LayoutParams params = viewGroup.generateLayoutParams(attrs);
                 rInflateChildren(parser, view, attrs, true);
                 viewGroup.addView(view, params);
             }
         }

          //parent的所有子节点都处理完毕的时候回onFinishInflate方法
         if (finishInflate) {
             parent.onFinishInflate();
         }
     }
     //可以添加自定义逻辑
      protected void onFinishInflate() {
      }
```
