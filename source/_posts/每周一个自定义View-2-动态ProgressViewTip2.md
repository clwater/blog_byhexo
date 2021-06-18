---
title: 每周一个自定义View-2-动态ProgressViewTip2
date: 2021-06-17 21:34:51
tags:
---

# 每周一个自定义View-2-动态ProgressViewTip2

> 其实功能周一就已经实现了, 不过后面的内容感觉比功能的实现还繁琐

照理先看下效果, 这里可以看到, 随着进度的变化越快, tip偏移的角度也越大, 给人一种加速度高的感觉
![动画效果](https://update-image.oss-cn-shanghai.aliyuncs.com/image/20210617215220.gif)


## 设计过程
### 静态分解
这个view整体看来还是比较简单的, 可以分成背景和文字的展示

![静态分解](https://update-image.oss-cn-shanghai.aliyuncs.com/image/20210617220232.gif)

背景的话可以看做一个圆角矩形和一个等边三角形, 显示的文字的话只要让文字在矩形的中心显示就可以了

### 动画效果
动画效果也比较简单, 根据当前需要变化的进度按照比例来旋转整体的角度即可
![动画效果](https://update-image.oss-cn-shanghai.aliyuncs.com/image/20210617221840.gif)


## 代码实现
代码相对来说还是比较简单的, 就不分模块展示了
```java
@Override
    protected void onDraw(Canvas canvas) {
        //绘制区域下移, 避免顶部动画时内容缺失
        canvas.translate(0, tipHeight / 3);
        //更新绘制坐标位置
        int tipPosition = (int) ((width - tipWidth) / 100f * progress);

        //避免差值器过度至异常位置
        if (tipPosition < tipWidth / 6) {
            tipPosition = tipWidth / 6;
        } else if (tipPosition > width - tipWidth / 6f * 7) {
            tipPosition = (int) (width - tipWidth / 6f * 7);
        }

        //背景绘制Paint
        Paint paint = new Paint();
        paint.setColor(backgroundColor);

        //移动到中心的位置
        canvas.translate(tipPosition, 0);

        //更新需要变化的角度
        int degrees = (int) (changeProgress / 100f * maxDegrees);

        //旋转整体
        canvas.rotate(degrees, tipWidth >> 1,
                tipHeight + triangleWith);
        canvas.save();

        //绘制圆角矩形区域
        canvas.drawRoundRect(0,
                0,
                tipWidth,
                tipHeight,
                30, 30, paint);
        canvas.translate(tipWidth >> 1, tipHeight);

        //绘制底部三角区域
        Path path = new Path();
        path.moveTo(-triangleWith >> 1, 0);
        path.lineTo(triangleWith >> 1, 0);
        path.lineTo(0, triangleWith);
        path.close();
        canvas.drawPath(path, paint);

        canvas.restore();
        canvas.save();

        //文件绘制Paint
        Paint textPaint = new Paint();
        textPaint.setColor(textColor);
        textPaint.setTextSize(tipHeight >> 1);
        textPaint.setStyle(Paint.Style.FILL);

        //使得在文字x轴居中
        textPaint.setTextAlign(Paint.Align.CENTER);

        //使得在文字y轴居中
        Paint.FontMetrics fontMetrics = textPaint.getFontMetrics();
        float top = fontMetrics.top;
        float bottom = fontMetrics.bottom;
        int baseLineY = (int) ((tipHeight >> 1) - top / 2 - bottom / 2);

        //避免差值器引起的取值异常
        if (progress < 0) {
            progress = 0;
        } else if (progress > 100) {
            progress = 100;
        }
        //更新需要展示的文字信息
        String text = "" + progress + "%";
        canvas.drawText(text, tipWidth >> 1, baseLineY, textPaint);
    }
```