import streamlit as st

st.set_page_config(page_title="Assistente Fit", page_icon="🥗")

st.title("🥗 Assistente de Saúde e Contador de Calorias")
st.write("Calcule suas metas, veja sugestões de treino e acompanhe seu dia.")

# Formulário de perfil
st.sidebar.header("Seus Dados")
peso = st.sidebar.number_input("Peso (kg)", min_value=30.0, max_value=200.0, value=70.0)
altura = st.sidebar.number_input("Altura (cm)", min_value=100.0, max_value=230.0, value=170.0)
idade = st.sidebar.number_input("Idade", min_value=10, max_value=100, value=25)
sexo = st.sidebar.selectbox("Sexo", ["Masculino", "Feminino"])

# Cálculo de TMB
if sexo == "Masculino":
    tmb = 88.36 + (13.4 * peso) + (4.8 * altura) - (5.7 * idade)
else:
    tmb = 447.6 + (9.2 * peso) + (3.1 * altura) - (4.3 * idade)

objetivo = st.selectbox(
    "Qual é o seu objetivo?",
    ["Perder gordura", "Ganhar massa muscular", "Manter a saúde"]
)

if objetivo == "Perder gordura":
    meta = tmb * 1.2 - 300
    treinos = ["Corrida leve (30 min)", "Circuito funcional", "Pular corda"]
elif objetivo == "Ganhar massa muscular":
    meta = tmb * 1.4 + 300
    treinos = ["Treino de força/Musculação", "Exercícios compostos", "Descanso adequado"]
else:
    meta = tmb * 1.3
    treinos = ["Caminhada (8k a 10k passos)", "Mobilidade e alongamento", "Natação ou bike"]

st.metric(label="Meta Calórica Diária Estimada", value=f"{meta:.0f} kcal")

# Exercícios
st.subheader("🏋️ Sugestão de Treino")
for t in treinos:
    st.write(f"- {t}")

# Registro de alimentos
st.subheader("🍎 Registro de Refeições")

if 'total_calorias' not in st.session_state:
    st.session_state.total_calorias = 0

col1, col2 = st.columns(2)
with col1:
    alimento = st.text_input("Nome do alimento")
with col2:
    calorias = st.number_input("Calorias (kcal)", min_value=0.0, value=0.0)

if st.button("Adicionar Alimento"):
    if calorias > 0:
        st.session_state.total_calorias += calorias
        st.success(f"{alimento} adicionado!")

st.write(f"**Total Consumido Hoje:** {st.session_state.total_calorias:.0f} / {meta:.0f} kcal")
st.progress(min(st.session_state.total_calorias / meta, 1.0))

if st.button("Zerar Contador"):
    st.session_state.total_calorias = 0