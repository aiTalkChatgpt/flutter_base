package com.example.android_plugin.util


object JsonUtil {

    private fun addBlank(sb: StringBuilder, indent: Int) {
        try {
            for (i in 0 until indent) {
                sb.append('\t')
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }

    }

    fun formatJson(jsonStr: String?): String {
        try {
            if (null == jsonStr || "" == jsonStr) {
                return ""
            }
            val sb = StringBuilder()
            var last = '\u0000'
            var current = '\u0000'
            var indent = 0
            var isInQuotationMarks = false
            for (i in 0 until jsonStr.length) {
                last = current
                current = jsonStr[i]
                when (current) {
                    '"' -> {
                        if (last != '\\') {
                            isInQuotationMarks = !isInQuotationMarks
                        }
                        sb.append(current)
                    }
                    '{', '[' -> {
                        sb.append(current)
                        if (!isInQuotationMarks) {
                            sb.append('\n')
                            indent++
                            addBlank(sb, indent)
                        }
                    }
                    '}', ']' -> {
                        if (!isInQuotationMarks) {
                            sb.append('\n')
                            indent--
                            addBlank(sb, indent)
                        }
                        sb.append(current)
                    }
                    ',' -> {
                        sb.append(current)
                        if (last != '\\' && !isInQuotationMarks) {
                            sb.append('\n')
                            addBlank(sb, indent)
                        }
                    }
                    else -> sb.append(current)
                }
            }

            return sb.toString()
        } catch (e: Exception) {
            e.printStackTrace()
            return ""
        }
    }

}