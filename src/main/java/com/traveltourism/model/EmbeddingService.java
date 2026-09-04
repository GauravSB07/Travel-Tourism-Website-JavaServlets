package com.traveltourism.model;

import ai.onnxruntime.OrtEnvironment;
import ai.onnxruntime.OrtSession;
import ai.onnxruntime.OnnxTensor;
import ai.djl.huggingface.tokenizers.HuggingFaceTokenizer;
import ai.djl.huggingface.tokenizers.Encoding;

import java.io.InputStream;
import java.nio.file.Paths;
import java.util.Properties;
import java.util.Map;
import java.util.HashMap;
import java.nio.LongBuffer;

public class EmbeddingService {
    
    private static EmbeddingService instance;
    
    private OrtEnvironment env;
    private OrtSession session;
    private HuggingFaceTokenizer tokenizer;
    
    private EmbeddingService() {
        try {
            Properties props = new Properties();
            try (InputStream is = getClass().getClassLoader().getResourceAsStream("application.properties")) {
                if (is != null) {
                    props.load(is);
                }
            }
            String modelDir = props.getProperty("model.dir", "/home/rehat/dev/java/models/bge-m3/onnx");
            
            String modelPath = modelDir + "/model.onnx";
            String tokenizerPath = modelDir + "/tokenizer.json";
            
            tokenizer = HuggingFaceTokenizer.newInstance(Paths.get(tokenizerPath));
            env = OrtEnvironment.getEnvironment();
            session = env.createSession(modelPath, new OrtSession.SessionOptions());
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static synchronized EmbeddingService getInstance() {
        if (instance == null) {
            instance = new EmbeddingService();
        }
        return instance;
    }
    
    public float[] getEmbedding(String text) {
        try {
            Encoding encoding = tokenizer.encode(text);
            long[] iIds = encoding.getIds();
            long[] aMask = encoding.getAttentionMask();
            
            long[] shape = new long[] { 1, iIds.length };
            
            OnnxTensor inputIdsTensor = OnnxTensor.createTensor(env, LongBuffer.wrap(iIds), shape);
            OnnxTensor attentionMaskTensor = OnnxTensor.createTensor(env, LongBuffer.wrap(aMask), shape);
            
            Map<String, OnnxTensor> inputs = new HashMap<>();
            inputs.put("input_ids", inputIdsTensor);
            inputs.put("attention_mask", attentionMaskTensor);
            
            try (OrtSession.Result results = session.run(inputs)) {
                Object val = results.get(1).getValue();
                if (val instanceof float[][]) {
                    float[][] vec = (float[][]) val;
                    return vec[0];
                } else if (val instanceof float[][][]) {
                    float[][][] vec = (float[][][]) val;
                    return vec[0][0]; 
                }
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    public String vectorToMysql(float[] vector) {
        if (vector == null) return "[]";
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (int i = 0; i < vector.length; i++) {
            sb.append(vector[i]);
            if (i < vector.length - 1) {
                sb.append(",");
            }
        }
        sb.append("]");
        return sb.toString();
    }
}
