package com.example.android_plugin.util

import android.util.Log
import java.lang.StringBuilder


object MultiLogUtil {
    
    private var enableLog = true
    

    fun d(tag: String, msg: String) {
        try {
            if (enableLog) {
                Log.i(tag, msg)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }

    }

    @JvmStatic
    fun d(tag: String, msg: String, tr: Throwable) {
        try {
            if (enableLog) {
                Log.i(tag, msg, tr)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }

    }

    @JvmStatic
    fun i(tag: String, msg: String) {
        try {
            if (enableLog) {
                Log.i(tag, msg)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }

    }

    fun i(tag: String, tr: Throwable) {
        try {
            if (enableLog) {
                Log.i(tag, "", tr)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }

    }

    @JvmStatic
    fun e(tag: String, msg: String) {
        try {
            if (enableLog) {
                Log.e(tag, msg)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }

    }


    @JvmStatic
    fun json(tag: String, msg: String) {
        
        val stringBuilder = StringBuilder()
        val startHint = " \n----------------------------- $tag 开始打印----------------------------->>>\n"
        val endHint = "\n----------------------------- $tag 结束打印 over-----------------------------<<<\n"

        try {
            if (enableLog) {

                stringBuilder.append(startHint)

                stringBuilder.append("\n ${JsonUtil.formatJson(msg)} \n")

                stringBuilder.append(endHint)

                Log.i(tag, stringBuilder.toString())
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }

    }

    @JvmStatic
    fun iLog(tag: String?, log : String?) {

        if(!enableLog) return
        val stringBuilder = StringBuilder()
        val startHint = " \n----------------------------- $tag 开始打印----------------------------->>>\n"
        val endHint = "\n----------------------------- $tag 结束打印-----------------------------<<<\n"
        
        stringBuilder.append(startHint)

        stringBuilder.append("\n $log \n")

        stringBuilder.append(endHint)

        Log.i(tag,stringBuilder.toString())
    }
    
    @JvmStatic
    fun iLogNet(url: String?, params: String?, response: String?, tag: String?,
              isExpand:Boolean = false, isReslutExpand:Boolean = true) {

        if(!enableLog) return
        val stringBuilder = StringBuilder()
        val startHint = " \n==========================================================  开始请求 ==========================================================>>>\n"
        val endHint = "==========================================================  结束请求==========================================================<<<\n"


        stringBuilder.append(startHint)

        stringBuilder.append("请求链接： $url \n")

        if(!isExpand)
            stringBuilder.append("请求参数：$params \n")
        else
            stringBuilder.append("请求参数：${JsonUtil.formatJson(params)} \n")

        if(isReslutExpand)
            stringBuilder.append("请求结果： ${JsonUtil.formatJson(response)} \n")
        else
            stringBuilder.append("请求结果： $response \n")

        stringBuilder.append(endHint)

        printLogLimit(stringBuilder.toString(), tag)

    }

 
    private fun printLogLimit(log: String, tag: String?) {
        val maxLength = 4 * 1000
        val logBytes = log.toByteArray(charset("utf-8"))

        if (logBytes.size > maxLength) {

            val startLog = String(logBytes.copyOfRange(0,maxLength))
            val endLog = String(logBytes.copyOfRange(maxLength,logBytes.size))

            Log.i(tag, startLog)

            printLogLimit(endLog, tag)
        } else {
            Log.i(tag, log)
        }
    }
}
